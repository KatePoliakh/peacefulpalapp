import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';

class HotlineScreen extends StatelessWidget {
  static const routeName = '/hotline';

  const HotlineScreen({super.key});

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomeScreen.routeName);
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
    return Scaffold(
      appBar: CustomAppBar(title: 'Экстренная помощь'),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) => ListTile(
          title: Text('Горячая линия $i'),
          subtitle: Text('+7 (XXX) XXX-XX-XX'),
          trailing: const Icon(Icons.call),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2, 
        onItemTapped: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }
}