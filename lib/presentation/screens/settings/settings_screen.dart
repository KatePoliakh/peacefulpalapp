import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/hotline/hotline_screen.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';
import 'package:peacefulpalapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

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
      
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current theme: ${themeProvider.isDarkMode ? 'Dark' : 'Light'}',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Use system theme'),
                  value: true,
                  onChanged: (value) {
                    themeProvider.setSystemTheme();
                  },
                ),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('About app'),
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onItemTapped: (index) => _onItemTapped(index, context),
      ),
    );
  }
}