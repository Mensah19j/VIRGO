import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:virgo/models/enums.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/providers/settings_provider.dart';
import 'package:virgo/screens/auth/login_screen.dart';
import 'package:virgo/screens/auth/register_screen.dart';
import 'package:virgo/screens/auth/staff_login_screen.dart';
import 'package:virgo/screens/onboarding/onboarding_screen.dart';
import 'package:virgo/screens/splash/splash_screen.dart';
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
  final authState = ref.watch(authStateProvider);
  final settingsState = ref.watch(settingsStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
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
          if (user?.role == UserRole.student) {
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
      if (settingsState.isLoading || authState.isLoading) {
        return null;
      }
      
      final settings = settingsState.valueOrNull;
      final user = authState.valueOrNull;
      
      final isSplash = state.uri.path == '/splash';
      final isOnboarding = state.uri.path == '/onboarding';
      final isLogin = state.uri.path == '/login';
      final isRegister = state.uri.path == '/register';
      final isStaffLogin = state.uri.path == '/staff-login';

      if (settings != null && !settings.hasCompletedOnboarding) {
        if (!isOnboarding) return '/onboarding';
        return null;
      }

      if (user != null) {
        if (isSplash || isOnboarding || isLogin || isRegister) {
          if (user.role == UserRole.student) {
            return '/student/feed';
          } else {
            return '/staff/feed'; // Placeholder for next section
          }
        }
      } else {
        if (!isLogin && !isRegister && !isSplash && !isStaffLogin) {
          return '/login';
        }
      }

      return null;
    },
  );
}

