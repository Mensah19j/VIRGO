import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/providers/settings_provider.dart';
import 'package:virgo/screens/auth/login_screen.dart';
import 'package:virgo/screens/auth/register_screen.dart';
import 'package:virgo/screens/auth/staff_login_screen.dart';
// Student routes
import 'package:virgo/screens/student/student_shell.dart';
import 'package:virgo/screens/student/feed/student_feed_screen.dart';
import 'package:virgo/screens/student/motivation/motivation_screen.dart';
import 'package:virgo/screens/student/profile/student_profile_screen.dart';
// Staff routes
import 'package:virgo/screens/staff/staff_shell.dart';
import 'package:virgo/screens/staff/feed/staff_feed_screen.dart';
import 'package:virgo/screens/staff/feed/create_update_screen.dart';
import 'package:virgo/screens/staff/dashboard/dashboard_screen.dart';
import 'package:virgo/screens/staff/students/students_list_screen.dart';
import 'package:virgo/screens/staff/students/student_detail_screen.dart';
import 'package:virgo/screens/staff/profile/staff_profile_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  // We DO NOT watch providers here. Watching providers in the body of the router provider
  // causes the GoRouter instance to be recreated every time auth/settings change,
  // which resets the navigation stack to the initialLocation.
  
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: _RouterRefreshNotifier(ref),
    debugLogDiagnostics: true, // Enable for better terminal visibility
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/staff-login',
        builder: (context, state) => const StaffLoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final user = ref.read(authStateProvider).valueOrNull;
          if (user?.role == UserRole.student.name) {
            return StudentShell(child: child);
          }
          return StaffShell(child: child); 
        },
        routes: [
          // Student branch
          GoRoute(
            path: '/student/feed',
            builder: (context, state) => const StudentFeedScreen(),
          ),
          GoRoute(
            path: '/student/motivation',
            builder: (context, state) => const MotivationScreen(),
          ),
          GoRoute(
            path: '/student/profile',
            builder: (context, state) => const StudentProfileScreen(),
          ),
          // Staff branch
          GoRoute(
            path: '/staff/feed',
            builder: (context, state) => const StaffFeedScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateUpdateScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/staff/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/staff/students',
            builder: (context, state) => const StudentsListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final idStr = state.pathParameters['id']!;
                  return StudentDetailScreen(studentId: int.parse(idStr));
                },
              ),
            ],
          ),
          GoRoute(
            path: '/staff/profile',
            builder: (context, state) => const StaffProfileScreen(),
          ),
        ],
      )
    ],
    redirect: (context, state) {
      // Always read the freshest state from the providers
      final currentAuth = ref.read(authStateProvider);
      final currentSettings = ref.read(settingsStateProvider);

      final isLoading = currentSettings.isLoading || currentAuth.isLoading;
      
      if (isLoading) {
        print('[Virgo] Router Loading: settings=${currentSettings.isLoading}, auth=${currentAuth.isLoading}');
      }
      
      final settings = currentSettings.valueOrNull;
      final user = currentAuth.valueOrNull;

      final isLogin = state.uri.path == '/login';
      final isRegister = state.uri.path == '/register';
      final isStaffLogin = state.uri.path == '/staff-login';
      final isAuthPage = isLogin || isRegister || isStaffLogin;

      // 1. While loading, stay put
      if (isLoading) {
        return null;
      }

      // 2. Handle Authenticated Users
      if (user != null) {
        // If logged in, don't allow access to auth pages
        if (isAuthPage) {
          return (user.role == UserRole.student.name) 
              ? '/student/feed' 
              : '/staff/feed';
        }
        return null; // Stay on requested authenticated route
      } 

      // 3. Handle Unauthenticated Users
      if (!isAuthPage) {
        return '/login';
      }

      return null;
    },
  );
}

/// A notifier that bridges Riverpod states to GoRouter's refreshListenable.
/// This ensures the router re-evaluates redirects whenever auth or settings change.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    // Listen to all providers that affect navigation
    ref.listen(authStateProvider, (_, __) => notifyListeners());
    ref.listen(settingsStateProvider, (_, __) => notifyListeners());
  }
}

