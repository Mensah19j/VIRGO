import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State notifier that manages splash timer completion.
/// Using StateNotifier instead of FutureProvider so the completed state persists
/// and is accessible via ref.read() in the router redirect.
class SplashTimerNotifier extends StateNotifier<bool> {
  SplashTimerNotifier() : super(false) {
    _startTimer();
  }

  void _startTimer() async {
    print('[Virgo] Splash Timer Started (2s)...');
    await Future.delayed(const Duration(seconds: 2));
    print('[Virgo] Splash Timer Finished');
    if (mounted) {
      state = true;
    }
  }
}

final splashTimerProvider = StateNotifierProvider<SplashTimerNotifier, bool>((ref) {
  return SplashTimerNotifier();
});
