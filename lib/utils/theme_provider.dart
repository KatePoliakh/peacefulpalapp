// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:peacefulpalapp/utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode;

  ThemeProvider({bool isDarkMode = false}) : _isDarkMode = isDarkMode;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setSystemTheme() {
    final brightness =
        MediaQueryData.fromView(
          WidgetsBinding.instance.window,
        ).platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
    notifyListeners();
  }

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;
}
