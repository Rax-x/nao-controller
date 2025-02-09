import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/configs.dart';
import 'package:nao_controller/presentation/providers/shared_preferences_provider.dart';
import 'package:nao_controller/presentation/screens/connect_screen.dart';
import 'package:nao_controller/presentation/screens/home_screen.dart';
import 'package:nao_controller/presentation/screens/walk_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_routes.dart' as routes;
import 'colors.dart' as colors;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance){
    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(instance)
        ],
        child: const MyApp(),
      )
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final preferences = ref.read(sharedPreferencesProvider);

    return MaterialApp(
      title: 'Nao Controller',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          surface: Colors.white,
          onSurface: colors.dark,
          primary: colors.primary,
          onPrimary:  Colors.white,
          secondary: colors.lightBlue,
          onSecondary: colors.dark,
          error: colors.red,
          onError: Colors.white
        ),
        useMaterial3: true,
      ),
      routes: {
        routes.home: (context) => const HomeScreen(),
        routes.connect: (context) => const ConnectScreen(),
        routes.walk: (context) => const WalkScreen()
      },
      initialRoute: preferences.containsKey(naoIpAddressKey) 
        ? routes.home
        : routes.connect
    );
  }
}

