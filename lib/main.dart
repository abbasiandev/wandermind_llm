import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/map_config.dart';
import 'core/theme/app_theme.dart';
import 'core/provider/app_provider.dart';
import 'core/widget/app_lifecycle_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MapConfig.initialize();

  await Hive.initFlutter();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const WanderMindApp(),
    ),
  );
}

class WanderMindApp extends ConsumerWidget {
  const WanderMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return AppLifecycleManager(
      child: MaterialApp.router(
        title: 'WanderMind LLM',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
