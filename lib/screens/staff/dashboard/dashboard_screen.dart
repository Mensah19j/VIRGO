import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/core/utils/date_utils.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';
import 'package:virgo/repositories/motivation_repository.dart';
import 'package:virgo/widgets/glossy_card.dart';
import 'package:virgo/widgets/loading_indicator.dart';
import 'package:virgo/widgets/section_header.dart';
import 'package:virgo/screens/staff/dashboard/widgets/stat_card.dart';
import 'package:virgo/screens/staff/dashboard/widgets/motivation_line_chart.dart';
import 'package:virgo/screens/staff/dashboard/widgets/motivation_distribution_pie.dart';
import 'package:virgo/screens/staff/dashboard/widgets/year_group_bar_chart.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isLoading = true;

  // Stats
  int _totalStudents = 0;
  int _loggedToday = 0;
  double _avgMotivationToday = 0.0;

  // Charts
  Map<int, double> _last7DaysData = {};
  Map<int, int> _distribution = {};
  Map<String, double> _yearGroupAverages = {};

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);

    try {
      final db = await ref.read(appDatabaseProvider.future);
      final authRepo = AuthRepository(db);
      final motivationRepo = MotivationRepository(db);

      final students = await authRepo.getAllStudents();
      _totalStudents = students.length;

      _loggedToday = await motivationRepo.getTotalLoggedToday();

      final today = AppDateUtils.dateOnly(DateTime.now());
      _avgMotivationToday = await motivationRepo.getAverageByDateRange(today, today);

      final weekAgo = today.subtract(const Duration(days: 6));
      _distribution = await motivationRepo.getDistribution(weekAgo, today);

      // Construct last 7 days line chart data
      Map<int, double> lineData = {};
      for (int i = 0; i < 7; i++) {
        final d = today.subtract(Duration(days: 6 - i));
        lineData[i] = await motivationRepo.getAverageByDateRange(d, d);
      }
      _last7DaysData = lineData;

      // Construct Year Group bar chart data
      Map<String, double> bgData = {};
      for (var group in AppConstants.yearGroups) {
        final grpStudents = await authRepo.getStudentsByYearGroup(group);
        if (grpStudents.isEmpty) continue;

        double sum = 0;
        int count = 0;
        for (var s in grpStudents) {
          final entries = await motivationRepo.getHistory(s.id, days: 7);
          for (var e in entries) {
            sum += e.level;
            count++;
          }
        }
        bgData[group] = count > 0 ? (sum / count) : 0.0;
      }
      _yearGroupAverages = bgData;

    } catch (e) {
      debugPrint('Error loading dashboard: $e');
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: const LoadingIndicator(message: 'Gathering insights...'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
            tooltip: 'Refresh Dashboard',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        color: AppColors.gold,
        backgroundColor: AppColors.wineDeep,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Headings Stats
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Logged Today',
                    value: '$_loggedToday / $_totalStudents',
                    icon: Icons.checklist_rtl_rounded,
                    color: AppColors.wine,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'Avg Today',
                    value: _avgMotivationToday.toStringAsFixed(1),
                    icon: Icons.speed_rounded,
                    color: AppColors.goldDeep,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            const SectionHeader(title: '7-Day Trend'),
            GlossyCard(
              child: MotivationLineChart(dataPoints: _last7DaysData),
            ),
            
            const SizedBox(height: 16),
            const SectionHeader(title: 'Distribution (Last 7 Days)'),
            GlossyCard(
              child: MotivationDistributionPie(distribution: _distribution),
            ),
            
            const SizedBox(height: 16),
            const SectionHeader(title: 'Average by Year Group'),
            GlossyCard(
              child: YearGroupBarChart(data: _yearGroupAverages),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
