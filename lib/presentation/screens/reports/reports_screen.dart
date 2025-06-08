import 'package:flutter/material.dart';
import 'package:peacefulpalapp/data/models/habit.dart';
import 'package:peacefulpalapp/data/repositories/habit_repository.dart';
import 'package:peacefulpalapp/presentation/screens/home/home_screen.dart';
import 'package:peacefulpalapp/presentation/screens/hotline/hotline_screen.dart';
import 'package:peacefulpalapp/presentation/screens/settings/settings_screen.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/screens/home/navigation.dart';

// ✅ Заменяем StatelessWidget на StatefulWidget
class ReportsScreen extends StatefulWidget {
  static const routeName = '/reports';

  const ReportsScreen({super.key});

  @override
  // ✅ Теперь правильно создаём State
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late Future<List<Habit>> _habitsFuture;

  @override
  void initState() {
    super.initState();
    _habitsFuture = HabitRepository().getHabits(1); // временно user_id = 1
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, HomeScreen.routeName);
        break;
      case 1:
        
        break;
      case 2:
        Navigator.pushNamed(context, HotlineScreen.routeName);
        break;
      case 3:
        Navigator.pushNamed(context, SettingsScreen.routeName);
        break;
    }
  }

  Widget _buildProgressChart(BuildContext context, Map<DateTime, bool> progress) {
    final theme = Theme.of(context);

    // Группируем по неделям
    final groupedByWeek = <String, List<bool>>{};

    for (var entry in progress.entries) {
      var weekKey = '${entry.key.year}-W${DateTime.now().difference(entry.key).inDays ~/ 7}';
      if (!groupedByWeek.containsKey(weekKey)) {
        groupedByWeek[weekKey] = [];
      }
      groupedByWeek[weekKey]?.add(entry.value);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: groupedByWeek.entries.map((entry) {
          final week = entry.key;
          final days = entry.value;
          final completed = days.where((d) => d).length;
          final total = days.length;
          final percent = (completed / total * 100).toInt();

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    week,
                    style: TextStyle(fontSize: 12, color: theme.hintColor),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 10,
                    backgroundColor: theme.primaryColor.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$percent% ($completed из $total)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'Your progress'),
      body: Stack(
        children: [
          // Фон
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

          // Декоративные круги
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
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
                color: isDarkMode
                    ? const Color(0xFF8E7CC3).withOpacity(0.3)
                    : const Color(0xFFC7B6F9).withOpacity(0.5),
              ),
            ),
          ),

          // Основной контент
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FutureBuilder<List<Habit>>(
              future: _habitsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                } else if (snapshot.data?.isEmpty ?? true) {
                  return const Center(child: Text('Нет привычек для отображения.'));
                } else {
                  final habits = snapshot.data!;
                  return ListView(
                    children: [
                      Text(
                        'Ваш прогресс',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),

                      ...habits.map((habit) {
                        return Card(
                          color: theme.cardColor.withOpacity(0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  habit.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildProgressChart(context, habit.progress),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),

      // ✅ bottomNavigationBar выносим за пределы Stack
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onItemTapped: (index) {
          _onItemTapped(index, context);
        },
      ),
    );
  }
}