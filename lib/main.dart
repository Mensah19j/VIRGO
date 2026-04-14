import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virgo/app.dart';
import 'package:virgo/providers/drift_database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: VirgoApp(),
    ),
  );
}

/// Bootstrap provider that ensures database is initialized
final appBootstrapProvider = FutureProvider<void>((ref) async {
  // Open the Drift database - this will trigger initialization
  await ref.watch(appDatabaseProvider.future);
  return;
});
