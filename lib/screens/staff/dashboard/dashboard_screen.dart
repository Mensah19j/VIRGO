import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/utils/date_utils.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';
import 'package:virgo/repositories/motivation_repository.dart';
import 'package:virgo/widgets/loading_indicator.dart';
import 'package:virgo/widgets/theme_switcher.dart';
import 'package:virgo/screens/staff/dashboard/widgets/stat_card.dart';

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

    } catch (e) {
      debugPrint('Error loading dashboard: $e');
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Analytics'),
          actions: const [ThemeSwitcher()],
        ),
        body: const LoadingIndicator(message: 'Gathering insights...'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadDashboardData,
            tooltip: 'Refresh Dashboard',
          ),
          const ThemeSwitcher(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        color: context.colorScheme.secondary,
        backgroundColor: context.colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Stats
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Logged Today',
                    value: '$_loggedToday / $_totalStudents',
                    icon: Icons.checklist_rtl_rounded,
                    color: context.appColors.wine,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'Avg Today',
                    value: _avgMotivationToday.toStringAsFixed(1),
                    icon: Icons.speed_rounded,
                    color: context.appColors.goldDeep,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

