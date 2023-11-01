import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum ThemeModeOptions { Light, Dark, System }

class ThemeProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _initPrefs();
  }
  

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final savedThemeMode = _prefs.getString('themeMode');

    if (savedThemeMode == null) {
      _themeMode = ThemeMode.system;
    } else {
      _themeMode = _getThemeModeFromString(savedThemeMode);
    }

    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  ThemeModeOptions get selectedMode {
    if (_themeMode == ThemeMode.light) {
      return ThemeModeOptions.Light;
    } else if (_themeMode == ThemeMode.dark) {
      return ThemeModeOptions.Dark;
    } else {
      return ThemeModeOptions.System;
    }
  }

  Future<void> setThemeMode(ThemeModeOptions themeModeOption) async {
    switch (themeModeOption) {
      case ThemeModeOptions.Light:
        _themeMode = ThemeMode.light;
        break;
      case ThemeModeOptions.Dark:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeModeOptions.System:
        _themeMode = ThemeMode.system;
        break;
    }

    await _saveThemeMode();
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    await _prefs.setString('themeMode', _themeMode.toString());
  }

  ThemeMode _getThemeModeFromString(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}