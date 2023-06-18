import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/screens/connect_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors.seed
        ),
        useMaterial3: true,
      ),
      home: const ConnectScreen(),
    );
  }
}
