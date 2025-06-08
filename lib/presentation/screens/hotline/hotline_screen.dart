// ignore_for_file: deprecated_member_use, avoid_types_as_parameter_names
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

    if (_countryCode == null) {
      return Scaffold(
        body: Stack(
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
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Emergency help'),
      body: Stack(
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

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FutureBuilder<Hotline?>(
              future: _dataSource.fetchHotlineByCountry(_countryCode!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text("No data for your country"),
                  );
                }

                final hotline = snapshot.data!;

                return ListView(
                  children: [
                    _buildServiceCard(
                      context,
                      label: 'Police',
                      numbers: hotline.policeNumbers,
                      icon: Icons.local_police,
                      chipColor: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _buildServiceCard(
                      context,
                      label: 'Ambulance',
                      numbers: hotline.ambulanceNumbers,
                      icon: Icons.local_hospital,
                      chipColor: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    _buildServiceCard(
                      context,
                      label: 'Fire brigate',
                      numbers: hotline.fireNumbers,
                      icon: Icons.fire_truck,
                      chipColor: Colors.orange,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onItemTapped: (index) => _onItemTapped(index, context),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String label,
    required List<String> numbers,
    required IconData icon,
    required Color chipColor,
  }) {
    final theme = Theme.of(context);

    if (numbers.isEmpty ||
        (numbers.length == 1 && numbers.first.trim().isEmpty)) {
      return Card(
        color: theme.cardColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Icon(icon, color: chipColor),
          title: Text(label),
          subtitle: const Text("Нет номера"),
        ),
      );
    }

    return Card(
      color: theme.cardColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: chipColor),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  numbers.map((num) {
                    return Chip(
                      backgroundColor: chipColor,
                      label: Text(
                        num,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
