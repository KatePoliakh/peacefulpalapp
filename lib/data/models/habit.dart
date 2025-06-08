class Habit {
  final int? id;
  final int userId;
  final String name;
  final int color; // int value (Color)
  final List<bool> daysCompleted;

  Habit({
    this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.daysCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'color': color,
      'daysCompleted': daysCompleted.toString(), // JSON строка
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    List<bool> _days;
    try {
      // дешифруем из '[true, false, ...]' в List<bool>
      final raw = map['daysCompleted'] as String;
      _days = raw.substring(1, raw.length - 1).split(',').map((e) => e.trim() == 'true').toList();
    } catch (_) {
      _days = List.filled(7, false);
    }
    return Habit(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      color: map['color'],
      daysCompleted: _days,
    );
  }
}
