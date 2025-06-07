import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/breathing/breathing_screen.dart';
import 'package:peacefulpalapp/presentation/screens/habits/habits_list_screen.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'navigation.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HabitsListScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Мое здоровье'),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, BreathingScreen.routeName);
        },
        label: const Text('Дыхание'),
        icon: const Icon(Icons.air),
      ),
    );
  }
}