import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/app.dart';
import 'package:virgo/providers/drift_database_provider.dart';
import 'package:virgo/providers/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: VirgoApp(),
    ),
  );
}

/// Bootstrap provider that ensures database and core settings are initialized
final appBootstrapProvider = FutureProvider<void>((ref) async {
  print('[Virgo] Bootstrap Beginning...');
  
  try {
    // Wait for database and initial theme with a safety timeout of 10 seconds
    await Future.wait([
      ref.watch(appDatabaseProvider.future),
      ref.watch(themeModeProvider.future),
    ]).timeout(const Duration(seconds: 10));
    
    print('[Virgo] Bootstrap Successful');
  } catch (e, stack) {
    print('[Virgo] Bootstrap encountered a delay or error: $e');
    print(stack);
    // We attempt to proceed even on error to avoid a permanent white/wine screen
  }
  
  return;
});

