import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (themeMode == newTheme) {
      return;
    }

    themeMode = newTheme;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDarkMode', newTheme == ThemeMode.dark);

    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDarkMode = prefs.getBool('isDarkMode') ?? false;

    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;
}
