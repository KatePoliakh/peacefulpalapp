// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:peacefulpalapp/data/repositories/habit_repository.dart';
import 'package:peacefulpalapp/data/repositories/auth_repository.dart';
import 'package:peacefulpalapp/data/models/habit.dart';
import 'package:peacefulpalapp/presentation/screens/habits/add_habit_screen.dart';
import 'package:peacefulpalapp/presentation/screens/habits/widgets/habit_card.dart';
import 'package:peacefulpalapp/presentation/screens/habits/widgets/week_days_header.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';

class HabitsListScreen extends StatefulWidget {
  static const routeName = '/habits';
  const HabitsListScreen({super.key});

  @override
  State<HabitsListScreen> createState() => _HabitsListScreenState();
}

class _HabitsListScreenState extends State<HabitsListScreen> {
  final HabitRepository _habitRepository = HabitRepository();
  final AuthRepository _authRepository = AuthRepository();
  List<Habit> _habits = [];
  int? _userId;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserAndHabits();
  }

  Future<void> _loadUserAndHabits() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final userId = await _authRepository.getCurrentUserId();
      if (userId == null) {
        setState(() {
          _error = "Вы не авторизованы";
        });
        return;
      }
      setState(() {
        _userId = userId;
      });
      await _loadHabits();
    } catch (e) {
      setState(() {
        _error = "Ошибка загрузки: $e";
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadHabits() async {
    if (_userId == null) return;
    final habits = await _habitRepository.getHabits(_userId!);
    setState(() {
      _habits = habits;
    });
  }

  Future<void> _addHabit(BuildContext context) async {
    if (_userId == null) return;
    final newHabit = await Navigator.pushNamed(
      context,
      AddHabitScreen.routeName,
    );
    if (newHabit != null && newHabit is Habit) {
      final habitWithUser = Habit(
        id: null,
        userId: _userId!,
        name: newHabit.name,
        color: newHabit.color,
        progress: newHabit.progress,
      );
      await _habitRepository.addHabit(habitWithUser);
      await _loadHabits();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Habits',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _addHabit(context),
        ),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWeekHeader(context),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      _loading
                          ? const Center(child: CircularProgressIndicator())
                          : _error != null
                          ? Center(
                            child: Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                          : _habits.isEmpty
                          ? Center(
                            child: Text(
                              'There is no habits yet. Create new!',
                              style: TextStyle(
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: _habits.length,
                            itemBuilder: (context, index) {
                              final habit = _habits[index];
                              return HabitCard(
                                habit: habit,
                                dates: List<DateTime>.generate(
                                  7,
                                  (i) => DateTime.now().add(Duration(days: -i)),
                                ),
                                onProgressChanged: (updatedHabit) async {
                                  await _habitRepository.updateHabit(
                                    updatedHabit,
                                  );
                                  await _loadHabits();
                                },
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekHeader(BuildContext context) {
    final today = DateTime.now();
    final dates = List<DateTime>.generate(
      7,
      (i) => today.add(Duration(days: i)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habit list',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        WeekDaysHeader(dates: dates),
      ],
    );
  }
}
