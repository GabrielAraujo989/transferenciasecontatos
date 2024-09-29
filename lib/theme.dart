import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 12, 231, 132)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 12, 231, 132), // Cor da AppBar
    titleTextStyle: TextStyle(
      color: Colors.white, // Cor do texto da AppBar
      fontSize: 20, // Tamanho do texto
      fontWeight: FontWeight.bold, // Peso do texto
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(fontWeight: FontWeight.bold),
  ),
);
