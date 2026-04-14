import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virgo/core/constants/app_constants.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/core/utils/validators.dart';
import 'package:virgo/providers/auth_provider.dart';
import 'package:virgo/widgets/app_text_field.dart';
import 'package:virgo/widgets/glossy_card.dart';
import 'package:virgo/widgets/gradient_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _selectedYearGroup;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedYearGroup == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a Year Group'),
            backgroundColor: AppColors.errorLight,
          ),
        );
        return;
      }

      await ref.read(authStateProvider.notifier).register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        yearGroup: _selectedYearGroup,
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
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go('/login'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Icon
                  const Center(
                    child: Icon(Icons.school_rounded, size: 52, color: AppColors.gold),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join the Virgo community as a student',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  GlossyCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppTextField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: _nameController,
                            validator: Validators.validateName,
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'Email Address',
                            hint: 'Enter your school email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'Password',
                            hint: 'Create a password',
                            controller: _passwordController,
                            isPassword: true,
                            validator: Validators.validatePassword,
                          ),
                          const SizedBox(height: 24),

                          // Year Group Dropdown
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                            child: Text(
                              'Year Group',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.wineLight,
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedYearGroup,
                            hint: const Text('Select your year group'),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                ),
                              ),
                            ),
                            items: AppConstants.yearGroups.map((group) {
                              return DropdownMenuItem(
                                value: group,
                                child: Text(group),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedYearGroup = value);
                            },
                          ),

                          const SizedBox(height: 32),
                          GradientButton(
                            text: 'Create Account',
                            isLoading: isLoading,
                            onPressed: _handleRegister,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      TextButton(
                        onPressed: isLoading ? null : () => context.go('/login'),
                        style: TextButton.styleFrom(foregroundColor: AppColors.wine),
                        child: const Text('Log in'),
                      ),
                    ],
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
