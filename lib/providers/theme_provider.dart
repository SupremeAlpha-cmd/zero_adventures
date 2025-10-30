import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A provider for managing theme changes and persisting the user's choice.
class ThemeProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  static const String _themeModeKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider(this.sharedPreferences) {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  // Loads the saved theme mode from SharedPreferences.
  void _loadThemeMode() {
    final savedTheme = sharedPreferences.getString(_themeModeKey);
    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
          break;
      }
    } 
    // No need to notify listeners on initial load
  }

  // Updates the theme mode and saves the choice to SharedPreferences.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return; // No change

    _themeMode = mode;
    notifyListeners();

    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
      default:
        themeString = 'system';
        break;
    }
    await sharedPreferences.setString(_themeModeKey, themeString);
  }
}
