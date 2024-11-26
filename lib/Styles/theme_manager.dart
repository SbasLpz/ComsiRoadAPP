import 'package:app_rutas_comsi/Styles/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final ThemeManager instancia = ThemeManager._internal();
  factory ThemeManager() {
    return instancia;
  }
  ThemeManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  ThemeAttrs myAttrs = LightThemeAttrs();
  ThemeAttrs get attrs => myAttrs;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    //bool isLight = attrs.mode == ThemeMode.light;
    //myAttrs = isLight ? DarkThemeAttrs() : LightThemeAttrs();
    _isDarkMode = !_isDarkMode;
    myAttrs = _isDarkMode ? DarkThemeAttrs() :  LightThemeAttrs();
    saveThemeMode(_isDarkMode);
    notifyListeners();
  }

  void saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    myAttrs = _isDarkMode ? DarkThemeAttrs() : LightThemeAttrs();
    notifyListeners();
  }

}