import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/core/utils/theme_extensions.dart';
import 'package:virgo/providers/settings_provider.dart';
import 'package:virgo/screens/onboarding/widgets/onboarding_page.dart';
import 'package:virgo/widgets/gradient_button.dart';
import 'package:virgo/widgets/theme_switcher.dart';

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
    // Navigation is handled automatically by the GoRouter redirect logic
    // once settingsStateProvider notifies the router of the change.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.appColors.wineDeep,
              context.appColors.wine,
              context.appColors.wineLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar with Switcher and Skip
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ThemeSwitcher(color: context.appColors.goldLight),
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: context.appColors.goldLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
                      imagePath: 'assets/app_icon.png',
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
                                ? context.appColors.gold
                                : context.appColors.goldLight.withValues(alpha: 0.3),
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

