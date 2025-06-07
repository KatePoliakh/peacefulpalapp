import 'package:flutter/material.dart';
import 'package:peacefulpalapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
      value: themeProvider.isDarkMode,
      onChanged: (value) => themeProvider.toggleTheme(),
      activeColor: Colors.purpleAccent,
    );
  }
}