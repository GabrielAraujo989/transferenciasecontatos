// theme.dart
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 12, 231, 132)),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(fontWeight: FontWeight.bold),
  ),
);
