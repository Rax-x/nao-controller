import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colors.dart' as colors;

void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nao Controller',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: Colors.white,
          onBackground: colors.dark,
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
      home: const Placeholder(),
    );
  }
}

