import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';
import 'package:peacefulpalapp/presentation/screens/hotline/hotline_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';

class ReportsScreen extends StatelessWidget {
  static const routeName = '/reports';

  const ReportsScreen({super.key});

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
      appBar: CustomAppBar(title: 'Your progress'),
      body: Center(
        child: Text('Personal progress', style: Theme.of(context).textTheme.titleLarge),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, 
        onItemTapped: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }
}