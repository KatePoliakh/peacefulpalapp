import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/datasources/hotline_api_data_source.dart';
import '../../../data/models/hotline.dart';
import '../../widgets/custom_app_bar.dart';
import '../home/navigation.dart';

class HotlineScreen extends StatelessWidget {
  static const routeName = '/hotline';
  const HotlineScreen({super.key});

  void _onItemTapped(int index, BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _callNumber(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataSource = HotlineApiDataSource();
    const countryCode = "RU";

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Экстренная помощь',
      ),
      body: FutureBuilder<Hotline?>(
        future: dataSource.fetchHotlineByCountry(countryCode),
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
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: Text('Страна: ${hotline.countryName}'),
              ),
              const Divider(),
              _buildLine(
                context,
                'Полиция',
                hotline.policeNumbers,
                Icons.local_police,
                Colors.blue,
              ),
              _buildLine(
                context,
                'Скорая помощь',
                hotline.ambulanceNumbers,
                Icons.local_hospital,
                Colors.red,
              ),
              _buildLine(
                context,
                'Пожарные',
                hotline.fireNumbers,
                Icons.fire_truck,
                Colors.orange,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLine(
    BuildContext context,
    String label,
    List<String> numbers,
    IconData icon,
    Color iconColor,
  ) {
    if (numbers.isEmpty ||
        (numbers.length == 1 && numbers.first.trim().isEmpty)) {
      return ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(label),
        subtitle: const Text('Нет номера'),
      );
    }
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(label),
      subtitle: Wrap(
        spacing: 12,
        children:
            numbers
                .map(
                  (num) => GestureDetector(
                    onTap: () => _callNumber(num),
                    child: Chip(
                      label: Text(
                        num,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: iconColor,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
