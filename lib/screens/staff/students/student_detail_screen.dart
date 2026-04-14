import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';
import 'package:virgo/repositories/motivation_repository.dart';
import 'package:virgo/screens/student/motivation/widgets/motivation_history_tile.dart';
import 'package:virgo/widgets/animated_avatar.dart';
import 'package:virgo/widgets/empty_state.dart';
import 'package:virgo/widgets/loading_indicator.dart';
import 'package:virgo/widgets/section_header.dart';
import 'package:virgo/widgets/theme_switcher.dart';
import 'package:virgo/screens/staff/dashboard/widgets/motivation_line_chart.dart';

class StudentDetailScreen extends ConsumerStatefulWidget {
  final int studentId;
  const StudentDetailScreen({super.key, required this.studentId});

  @override
  ConsumerState<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends ConsumerState<StudentDetailScreen> {
  bool _isLoading = true;
  User? _student;
  List<MotivationEntry> _history = [];
  Map<int, double> _chartData = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final db = await ref.read(appDatabaseProvider.future);
      final authRepo = AuthRepository(db);
      final motivationRepo = MotivationRepository(db);

      _student = await authRepo.getUserById(widget.studentId);
      if (_student != null) {
        _history = await motivationRepo.getHistory(_student!.id);

        // Build 7-day chart data
        Map<int, double> map = {};
        final now = DateTime.now();
        for (int i = 0; i < 7; i++) {
          final target = now.subtract(Duration(days: 6 - i));
          // Simple client-side average calc for this student
          final entriesOnDay = _history.where((e) {
            return e.date.year == target.year &&
                   e.date.month == target.month &&
                   e.date.day == target.day;
          }).toList();

          if (entriesOnDay.isNotEmpty) {
            final avg = entriesOnDay.fold<int>(0, (p, e) => p + e.level) / entriesOnDay.length;
            map[i] = avg;
          }
        }
        _chartData = map;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Student Details'),
          actions: const [ThemeSwitcher()],
        ),
        body: const LoadingIndicator(),
      );
    }

    if (_student == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Not Found'),
          actions: const [ThemeSwitcher()],
        ),
        body: const Center(child: Text('Student not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_student!.name),
        actions: const [ThemeSwitcher()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                AnimatedAvatar(name: _student!.name, radius: 48),
                const SizedBox(height: 16),
                Text(
                  _student!.name,
                  style: context.textTheme.headlineMedium,
                ),
                Text(
                  _student!.yearGroup ?? 'No Year Group',
                  style: TextStyle(
                    color: context.appColors.goldDeep,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_student!.email),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          const SectionHeader(title: '7-Day Form'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MotivationLineChart(dataPoints: _chartData),
            ),
          ),
          
          const SizedBox(height: 24),
          const SectionHeader(title: 'History Log'),
          if (_history.isEmpty)
            const EmptyState(
              title: 'No Logs',
              message: 'This student has not logged any motivation entries yet.',
              icon: Icons.history_rounded,
            )
          else
            ..._history.map((entry) => MotivationHistoryTile(entry: entry)),
        ],
      ),
    );
  }
}

