import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virgo/core/theme/app_colors.dart';
import 'package:virgo/providers/settings_provider.dart';
import 'package:virgo/screens/onboarding/widgets/onboarding_page.dart';
import 'package:virgo/widgets/gradient_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() async {
    await ref.read(settingsStateProvider.notifier).setOnboardingComplete();
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.wineDeep,
              AppColors.wine,
              AppColors.wineLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.goldLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: const [
                    OnboardingPage(
                      title: 'Welcome\nto Virgo',
                      description: 'Your premier companion for school journey and personal growth.',
                      icon: Icons.school_rounded,
                    ),
                    OnboardingPage(
                      title: 'Track Your\nMotivation',
                      description: 'Log your daily motivation levels to help the school better support your path to success.',
                      icon: Icons.mood_rounded,
                    ),
                    OnboardingPage(
                      title: 'Stay\nUpdated',
                      description: 'Never miss an important event, academic alert, or school announcement.',
                      icon: Icons.notifications_active_rounded,
                    ),
                  ],
                ),
              ),
              
              // Bottom controls
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Dot indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _currentPage == index ? 24.0 : 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppColors.gold
                                : AppColors.goldLight.withValues(alpha:0.3),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Button
                    _currentPage == 2
                        ? GradientButton(
                            text: 'Get Started',
                            isSecondary: true, // Gold button for contrast
                            onPressed: _completeOnboarding,
                          )
                        : GradientButton(
                            text: 'Next',
                            isSecondary: true,
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
