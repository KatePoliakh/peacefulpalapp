import 'package:flutter/material.dart';
import 'package:peacefulpalapp/utils/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool? _isDarkMode;

  bool get isDarkMode =>
      _isDarkMode ??
      MediaQueryData.fromView(
            WidgetsBinding.instance.window,
          ).platformBrightness ==
          Brightness.dark;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode!;
    notifyListeners();
  }

  void setSystemTheme() {
    _isDarkMode = null;
    notifyListeners();
  }

  ThemeData get currentTheme {
    if (_isDarkMode == null) {
      final brightness =
          MediaQueryData.fromView(
            WidgetsBinding.instance.window,
          ).platformBrightness;
      return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
    return _isDarkMode! ? darkTheme : lightTheme;
  }
}
