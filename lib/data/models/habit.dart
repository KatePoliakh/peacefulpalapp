class Habit {
  final int? id;
  final int userId;
  final String name;
  final int color;
  final Map<DateTime, bool> progress;

  Habit({
    this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.progress,
  });

  Map<String, dynamic> toMap() {
    List<String> progressList = [];
    progress.forEach((date, value) {
      final normalized = DateTime(date.year, date.month, date.day);
      progressList.add('${normalized.toIso8601String()}@$value');
    });
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'color': color,
      'progress': progressList.join(';'),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    String rawString = map['progress'] ?? '';
    List<String> rawProgress = rawString.isNotEmpty ? rawString.split(';') : [];
    Map<DateTime, bool> progressMap = {};
    for (var pair in rawProgress) {
      var parts = pair.split('@');
      if (parts.length == 2) {
        try {
          var d = DateTime.parse(parts[0]);
          final normalized = DateTime(d.year, d.month, d.day);
          var done = parts[1] == 'true';
          progressMap[normalized] = done;
        } catch (_) {}
      }
    }
    return Habit(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      color: map['color'],
      progress: progressMap,
    );
  }
}
