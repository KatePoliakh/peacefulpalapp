import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peacefulpalapp/utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode;
  ThemeProvider({bool initialDarkMode = false}) : _isDarkMode = initialDarkMode;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setSystemTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDarkMode ? darkTheme : lightTheme;
  }
}