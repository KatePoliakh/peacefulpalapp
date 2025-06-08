// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/habits/habits_list_screen.dart';
import 'package:peacefulpalapp/presentation/screens/breathing/breathing_screen.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';
import 'package:peacefulpalapp/presentation/screens/hotline/hotline_screen.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
       
        break;
      case 1:
        Navigator.pushNamed(context, ReportsScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, HotlineScreen.routeName);
      break;
      case 3:
        Navigator.pushNamed(context, SettingsScreen.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [ 
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? const [Color(0xFF4A3B78), Color(0xFF1E1E2F)]
                    : const [Color(0xFFC7B6F9), Color(0xFFF5F0FA)],
              ),
            ),
          ),

          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? const Color(0xFF8E7CC3).withOpacity(0.3)
                    : const Color(0xFFC7B6F9).withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? const Color(0xFF8E7CC3).withOpacity(0.3)
                    : const Color(0xFFC7B6F9).withOpacity(0.5),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Welcome back,\nUser!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 40),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, HabitsListScreen.routeName);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          _buildTileIconOrImage(
                            context,
                            icon: Icons.fitness_center,
                            imageAsset: 'assets/images/habit_icon.png',
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your Habits',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Track your daily habits and progress.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, BreathingScreen.routeName);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          _buildTileIconOrImage(
                            context,
                            icon: Icons.air,
                            imageAsset: 'assets/images/breathing_icon.png',
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Breathing Exercises',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Practice calming breathing techniques.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onItemTapped: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }

  Widget _buildTileIconOrImage(
    BuildContext context, {
    IconData? icon,
    String? imageAsset,
  }) {
    final theme = Theme.of(context);

    if (imageAsset != null) {
      return Image.asset(
        imageAsset,
        width: 48,
        height: 48,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            Icon(icon ?? Icons.question_mark, size: 40, color: theme.primaryColor),
      );
    } else if (icon != null) {
      return Icon(icon, size: 40, color: theme.primaryColor);
    } else {
      return const SizedBox.shrink();
    }
  }
}