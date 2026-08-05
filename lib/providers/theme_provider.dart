import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (themeMode == newTheme) {
      return;
    }
    themeMode = newTheme;
    notifyListeners();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;
}
