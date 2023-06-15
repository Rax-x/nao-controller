import 'package:flutter/material.dart';

import 'colors.dart' as colors;

void main() {
  runApp(const MyApp());
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
      home: Container(),
    );
  }
}
