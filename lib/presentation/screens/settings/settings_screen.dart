import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/theme_switcher.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';
import 'package:peacefulpalapp/presentation/screens/hotline/hotline_screen.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedCountry = 'RU';
  final _countries = const {
    'RU': 'Russia',
    'BY': 'Belarus',
    'AM': 'Armenia',
    'CA': 'Canada',
    'CN': 'China',
    'CO': 'Colombia',
    'FR': 'France',
    'DE': 'Germany',
    'IT': 'Italy',
  };

  @override
  void initState() {
    super.initState();
    _loadCountry();
  }

  Future<void> _loadCountry() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCountry = prefs.getString('user_country_code') ?? 'RU';
    });
  }

  Future<void> _saveCountry(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_country_code', code);
    setState(() {
      _selectedCountry = code;
    });
  }

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
      appBar: CustomAppBar(title: 'Settings'),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Change theme'),
            trailing: const ThemeSwitcher(),
          ),
          const Divider(),
          ListTile(
            title: const Text('Choose country'),
            subtitle: DropdownButton<String>(
              value: _selectedCountry,
              items:
                  _countries.entries
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.key,
                          child: Text('${e.value} (${e.key})'),
                        ),
                      )
                      .toList(),
              onChanged: (code) {
                if (code != null) {
                  _saveCountry(code);
                }
              },
            ),
          ),
          const Divider(),
          ListTile(title: const Text('About app'), onTap: () {}),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onItemTapped: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }
}
