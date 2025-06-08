// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class HabitCard extends StatefulWidget {
  final String name;
  final Color color;
  final List<bool> daysCompleted;
  final List<DateTime> dates;
 
  const HabitCard({
    super.key,
    required this.name,
    required this.color,
    required this.daysCompleted,
    required this.dates,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late List<bool> _daysCompleted;
  double get progress => (_daysCompleted.where((d) => d).length / _daysCompleted.length) * 100;

  @override
  void initState() {
    super.initState();
    _daysCompleted = List.from(widget.daysCompleted);
  }

  void _toggleDay(int index) {
    setState(() {
      _daysCompleted[index] = !_daysCompleted[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
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
                    backgroundColor: widget.color,
                    child: Text(
                      '${progress.toInt()}%',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      minHeight: 8,
                      backgroundColor: widget.color.withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: List.generate(7, (i) {
                  return GestureDetector(
                    onTap: () => _toggleDay(i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Icon(
                        _daysCompleted[i] ? Icons.check_circle : Icons.circle_outlined,
                        size: 24,
                        color: _daysCompleted[i]
                            ? theme.primaryColor
                            : theme.hintColor,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}