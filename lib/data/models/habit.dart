class Habit {
  final int? id;
  final int userId;
  final String name;
  final int color; // Color.value
  final Map<DateTime, bool> progress;

  Habit({
    this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.progress,
  });

  Map<String, dynamic> toMap() {
    List<String> _progressList = [];

    progress.forEach((date, done) {
      _progressList.add('${date.toString()}:$done');
    });

    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'color': color,
      'progress': _progressList.join(';'),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    List<String> rawProgress = (map['progress'] as String).split(';');

    Map<DateTime, bool> _progressMap = {};

    for (var pair in rawProgress) {
      var parts = pair.split(':');
      if (parts.length == 2) {
        try {
          var date = DateTime.parse(parts[0]);
          var done = parts[1] == 'true';
          _progressMap[date] = done;
        } catch (_) {}
      }
    }

    return Habit(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'],
      color: map['color'],
      progress: _progressMap,
    );
  }
}
