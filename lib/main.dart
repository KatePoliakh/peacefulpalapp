import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/auth/login_screen.dart';
import 'package:peacefulpalapp/presentation/screens/auth/register_screen.dart';
import 'package:peacefulpalapp/presentation/screens/auth/splash_screen.dart';
import 'package:peacefulpalapp/presentation/screens/breathing/breathing_screen.dart';
import 'package:peacefulpalapp/presentation/screens/habits/add_habit_screen.dart';
import 'package:peacefulpalapp/presentation/screens/habits/habits_list_screen.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/hotline/hotline_screen.dart';
import 'package:peacefulpalapp/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';
import 'package:peacefulpalapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ), 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'PeacefulPal',
      theme: themeProvider.currentTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        HabitsListScreen.routeName: (context) => HabitsListScreen(),
        AddHabitScreen.routeName: (context) => const AddHabitScreen(),
        BreathingScreen.routeName: (context) => const BreathingScreen(),
        ReportsScreen.routeName: (context) => ReportsScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        HotlineScreen.routeName: (context) => const HotlineScreen(),
      },
    );
  }
}