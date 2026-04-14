import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/core/utils/validators.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/widgets/app_text_field.dart';
import 'package:virgo/widgets/glossy_card.dart';
import 'package:virgo/widgets/gradient_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authStateProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (!mounted) return;
      
      final authState = ref.read(authStateProvider);
      
      if (authState.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.error.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.errorLight,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authStateProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                isDark ? AppColors.surfaceElevatedDark : AppColors.surfaceElevatedLight,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Branding
                  const Icon(
                    Icons.school_rounded,
                    size: 64,
                    color: AppColors.gold,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue to Virgo',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Login Form inside Glossy Card
                  GlossyCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppTextField(
                            label: 'Email Address',
                            hint: 'Enter your school email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _passwordController,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            validator: Validators.validatePassword,
                            onSubmitted: (_) => _handleLogin(),
                          ),
                          const SizedBox(height: 32),
                          GradientButton(
                            text: 'Sign In',
                            isLoading: isLoading,
                            onPressed: _handleLogin,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),

                  // Navigation to Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      TextButton(
                        onPressed: isLoading ? null : () => context.go('/register'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.wine,
                        ),
                        child: const Text('Register here'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Divider with label
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Staff portal link
                  Center(
                    child: TextButton.icon(
                      onPressed: isLoading ? null : () => context.go('/staff-login'),
                      icon: const Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 18,
                        color: AppColors.goldDeep,
                      ),
                      label: const Text(
                        'Are you a staff member? Click here',
                        style: TextStyle(
                          color: AppColors.goldDeep,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
