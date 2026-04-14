import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/database/app_database.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/repositories/auth_repository.dart';
import 'package:virgo/repositories/motivation_repository.dart';
import 'package:virgo/widgets/animated_avatar.dart';
import 'package:virgo/widgets/loading_indicator.dart';

class StudentsListScreen extends ConsumerStatefulWidget {
  const StudentsListScreen({super.key});

  @override
  ConsumerState<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends ConsumerState<StudentsListScreen> {
  bool _isLoading = true;
  List<User> _allStudents = [];
  List<User> _filteredStudents = [];
  Map<int, int?> _latestMotivation = {}; // UserId -> MotivationLevel

  String _searchQuery = '';
  String? _selectedYearGroup;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);

    try {
      final db = await ref.read(appDatabaseProvider.future);
      final authRepo = AuthRepository(db);
      final motivationRepo = MotivationRepository(db);

      final students = await authRepo.getAllStudents();

      // Fetch latest motivation for each
      Map<int, int?> motiveMap = {};
      for (var s in students) {
        final recent = await motivationRepo.getHistory(s.id);
        if (recent.isNotEmpty) {
          motiveMap[s.id] = recent.first.level;
        } else {
          motiveMap[s.id] = null;
        }
      }

      _allStudents = students;
      _latestMotivation = motiveMap;
      _applyFilters();

    } catch (e) {
      debugPrint('Error loading students: $e');
    }

    if (mounted) setState(() => _isLoading = false);
  }

  void _applyFilters() {
    setState(() {
      _filteredStudents = _allStudents.where((s) {
        final matchesSearch = s.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesYear = _selectedYearGroup == null || s.yearGroup == _selectedYearGroup;
        return matchesSearch && matchesYear;
      }).toList();
      
      // Sort alphabetically
      _filteredStudents.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students Directory'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) {
                    _searchQuery = val;
                    _applyFilters();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search students by name...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).cardTheme.color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: const Text('All Years'),
                          selected: _selectedYearGroup == null,
                          onSelected: (selected) {
                            if (selected) {
                              _selectedYearGroup = null;
                              _applyFilters();
                            }
                          },
                        ),
                      ),
                      ...AppConstants.yearGroups.map((group) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(group),
                            selected: _selectedYearGroup == group,
                            onSelected: (selected) {
                              _selectedYearGroup = selected ? group : null;
                              _applyFilters();
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const LoadingIndicator(message: 'Loading student list...')
          : _filteredStudents.isEmpty
              ? const Center(child: Text('No students found.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = _filteredStudents[index];
                    final latestLevel = _latestMotivation[student.id];
                    final hasLogged = latestLevel != null;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: AnimatedAvatar(name: student.name, radius: 24),
                        title: Text(
                          student.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(student.yearGroup ?? 'No Year Group'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (hasLogged)
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.getMotivationColor(latestLevel).withValues(alpha:0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  AppConstants.motivationEmojis[latestLevel]!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              )
                            else
                              const Tooltip(
                                message: 'No entry today',
                                child: Icon(Icons.help_outline, color: Colors.grey),
                              ),
                            const SizedBox(width: 8),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                        onTap: () {
                          // Navigate to detail
                          // Since we don't have nested parameterized routes yet, 
                          // we can use a stateful extra or simple push.
                          context.push('/staff/students/${student.id}');
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
