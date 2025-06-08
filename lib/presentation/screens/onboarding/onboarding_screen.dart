// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/auth/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({super.key});

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
                    ? [
                        const Color(0xFF4A3B78),
                        const Color(0xFF1E1E2F),
                      ]
                    : [
                        const Color(0xFFC7B6F9),
                        const Color(0xFFF5F0FA),
                      ],
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
                    : const Color(0xFFC7B6F9).withOpacity(0.3),
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
                    : const Color(0xFFC7B6F9).withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: -50,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? const Color(0xFF8E7CC3).withOpacity(0.3)
                    : const Color(0xFFC7B6F9).withOpacity(0.3),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start your journey',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'to wellness',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Image.asset(
                    'assets/images/girl_with_heart.png',
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: isDarkMode ? Colors.black : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      elevation: 4,
                    ),
                    child: const Text('Get started'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}