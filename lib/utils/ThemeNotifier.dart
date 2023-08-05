
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = 
    _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}