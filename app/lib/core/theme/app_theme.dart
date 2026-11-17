import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF1B6B4A));
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
  );
}
