// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class WeekDaysHeader extends StatelessWidget {
  final List<DateTime> dates;
  final List<String> dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  WeekDaysHeader({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: dates.map((date) {
        final dayName = dayNames[date.weekday - 1];
        final dayNumber = date.day;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$dayNumber',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}