import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/theme_switcher.dart';
import 'package:peacefulpalapp/presentation/screens/auth/login_screen.dart';
import 'package:peacefulpalapp/data/repositories/auth_repository.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedCountry = 'RU';
  final Map<String, String> _countries = const {
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

  final AuthRepository _authRepository = AuthRepository();

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

  Future<void> _handleLogout(BuildContext context) async {
    await _authRepository.logout();

    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'Настройки'),
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

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Сменить тему'),
                  trailing: const ThemeSwitcher(),
                ),
                const Divider(),

                ListTile(
                  title: const Text('Выберите страну'),
                  subtitle: DropdownButton<String>(
                    value: _selectedCountry,
                    items: _countries.entries
                        .map((e) => DropdownMenuItem<String>(
                              value: e.key,
                              child: Text('${e.value} (${e.key})'),
                            ))
                        .toList(),
                    onChanged: (code) {
                      if (code != null) {
                        _saveCountry(code);
                      }
                    },
                  ),
                ),
                const Divider(),

                ListTile(
                  title: const Text('О приложении'),
                  onTap: () {},
                ),
                const Divider(),

                ElevatedButton.icon(
                  onPressed: () => _handleLogout(context),
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: const Text('Выйти из аккаунта'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}