import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontSize: 24, color: Colors.grey, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.normal),
      titleSmall: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 20, color: Colors.cyan, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal)
    ),
    primaryColor: Colors.white,
    dividerColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 0, 191, 50))),
    ),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 2),
    focusColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.black));

final darkTheme = ThemeData(
  brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 68, 68, 68),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
      titleSmall: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 20, color: Colors.cyan, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal)
    ),
    primaryColor: const Color.fromARGB(255, 68, 68, 68),
    dividerColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 68, 68, 68)),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(150, 0, 191, 50))),
    ),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 2),
    focusColor: Colors.grey,
    iconTheme: const IconThemeData(color: Colors.white));