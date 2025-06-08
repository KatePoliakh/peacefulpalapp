import 'package:flutter/material.dart';

class Habit {
  final String id;
  final String name;
  final Color color;
  final List<bool> daysCompleted;

  Habit({
    required this.id,
    required this.name,
    required this.color,
    required this.daysCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color.value,
      'daysCompleted': daysCompleted,
    };
  }

  factory Habit.fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      name: map['name'] ?? '',
      color: Color(map['color']),
      daysCompleted: (map['daysCompleted'] as List).map((e) => e as bool).toList(),
    );
  }
}
