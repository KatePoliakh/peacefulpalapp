import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/reports/reports_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peacefulpalapp/data/datasources/hotline_api_data_source.dart';
import 'package:peacefulpalapp/data/models/hotline.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';

class HotlineScreen extends StatefulWidget {
  static const routeName = '/hotline';
  const HotlineScreen({super.key});

  @override
  State<HotlineScreen> createState() => _HotlineScreenState();
}

class _HotlineScreenState extends State<HotlineScreen> {
  String? _countryCode;
  late HotlineApiDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = HotlineApiDataSource();
    _loadCountryCode();
  }

  Future<void> _loadCountryCode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _countryCode = prefs.getString('user_country_code') ?? 'RU';
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
    if (_countryCode == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Экстренная помощь'),
      body: FutureBuilder<Hotline?>(
        future: _dataSource.fetchHotlineByCountry(_countryCode!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          }

          final hotline = snapshot.data;
          if (hotline == null) {
            return const Center(child: Text("Нет данных для вашей страны"));
          }

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: Text(
                  'Страна: ${hotline.countryName} (${_countryCode!})',
                ),
              ),
              const Divider(),
              _buildNumbersTile(
                context,
                label: 'Полиция',
                numbers: hotline.policeNumbers,
                icon: Icons.local_police,
                chipColor: Colors.blue,
              ),
              _buildNumbersTile(
                context,
                label: 'Скорая помощь',
                numbers: hotline.ambulanceNumbers,
                icon: Icons.local_hospital,
                chipColor: Colors.red,
              ),
              _buildNumbersTile(
                context,
                label: 'Пожарная служба',
                numbers: hotline.fireNumbers,
                icon: Icons.fire_truck,
                chipColor: Colors.orange,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onItemTapped: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }

  Widget _buildNumbersTile(
    BuildContext context, {
    required String label,
    required List<String> numbers,
    required IconData icon,
    required Color chipColor,
  }) {
    if (numbers.isEmpty ||
        (numbers.length == 1 && numbers.first.trim().isEmpty)) {
      return ListTile(
        leading: Icon(icon, color: chipColor),
        title: Text(label),
        subtitle: const Text("Нет номера"),
      );
    }
    return ListTile(
      leading: Icon(icon, color: chipColor),
      title: Text(label),
      subtitle: Wrap(
        spacing: 10,
        children:
            numbers.map((num) {
              return GestureDetector(
                child: Chip(
                  label: Text(num, style: const TextStyle(color: Colors.white)),
                  backgroundColor: chipColor,
                ),
              );
            }).toList(),
      ),
    );
  }
}
