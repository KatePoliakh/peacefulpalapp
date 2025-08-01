// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:peacefulpalapp/data/models/habit.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final List<DateTime> dates;
  final Function(Habit updatedHabit)? onProgressChanged;

  const HabitCard({
    super.key,
    required this.habit,
    required this.dates,
    this.onProgressChanged,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late Habit _habit;

  double get progress {
    if (_habit.progress.isEmpty) return 0.0;
    final completed = _habit.progress.values.where((v) => v).length;
    return (completed / _habit.progress.length) * 100;
  }

  @override
  void initState() {
    super.initState();
    _habit = widget.habit;
  }

  void _toggleDay(DateTime date) {
    setState(() {
      final day = DateTime(date.year, date.month, date.day);
      final old = _habit.progress[day] ?? false;
      _habit.progress[day] = !old;
    });
    widget.onProgressChanged?.call(_habit);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(_habit.color).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(_habit.color),
                    child: Text(
                      '${progress.toInt()}%',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      minHeight: 8,
                      backgroundColor: Color(_habit.color).withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(_habit.color),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                _habit.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),

              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children:
                    widget.dates.map((date) {
                      final isDone =
                          _habit.progress[DateTime(
                            date.year,
                            date.month,
                            date.day,
                          )] ??
                          false;

                      return GestureDetector(
                        onTap: () => _toggleDay(date),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Icon(
                            isDone ? Icons.check_circle : Icons.circle_outlined,
                            size: 24,
                            color:
                                isDone ? theme.primaryColor : theme.hintColor,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
