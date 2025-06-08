// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:peacefulpalapp/data/datasources/zen_quote_api_data_source.dart';
import 'package:peacefulpalapp/data/models/zen_quote.dart';
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
          _buildBackground(theme, isDarkMode),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildGreeting(theme),
                  const SizedBox(height: 32),

                  FutureBuilder<ZenQuote?>(
                    future: ZenQuoteApiDataSource().fetchQuote(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text("Failed to load quote"),
                        );
                      }
                      final quote = snapshot.data;
                      if (quote == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24, top: 8),
                        child: Card(
                          elevation: 0,
                          color: theme.cardColor.withOpacity(0.74),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '"${quote.quote}"',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    color:
                                        theme.textTheme.bodyLarge?.color ??
                                        Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "- ${quote.author}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: theme.primaryColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Карточка привычек
                  _buildTileCard(
                    context,
                    icon: Icons.fitness_center,
                    title: 'Your Habits',
                    subtitle: 'Track your daily habits and progress.',
                    onTap: () {
                      Navigator.pushNamed(context, HabitsListScreen.routeName);
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildTileCard(
                    context,
                    icon: Icons.air,
                    title: 'Breathing Exercises',
                    subtitle: 'Practice calming breathing techniques.',
                    onTap: () {
                      Navigator.pushNamed(context, BreathingScreen.routeName);
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onItemTapped: (index) => _onItemTapped(index, context),
      ),
    );
  }

  Widget _buildGreeting(ThemeData theme) {
    return Text(
      'Welcome back!',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      ),
    );
  }

  Widget _buildTileCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: const BoxConstraints(minHeight: 140),
        margin: const EdgeInsets.symmetric(vertical: 2),
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
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: theme.primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.8,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: theme.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(ThemeData theme, bool isDarkMode) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  isDarkMode
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
              color:
                  isDarkMode
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
              color:
                  isDarkMode
                      ? const Color(0xFF8E7CC3).withOpacity(0.3)
                      : const Color(0xFFC7B6F9).withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
