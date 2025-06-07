import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/theme_switcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Настройки'),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Темная тема'),
            trailing: const ThemeSwitcher(),
          ),
          const Divider(),
          ListTile(
            title: const Text('Уведомления'),
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          ListTile(
            title: const Text('О приложении'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}