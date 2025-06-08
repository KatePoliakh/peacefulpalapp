import '../database/app_database.dart';
import '../models/habit.dart';

class HabitRepository {
  Future<List<Habit>> getHabits(int userId) async {
    final db = await AppDatabase.database;
    final result = await db.query('habits', where: 'user_id = ?', whereArgs: [userId]);
    return result.map((map) => Habit.fromMap(map)).toList();
  }

  Future<void> addHabit(Habit habit) async {
    final db = await AppDatabase.database;
    await db.insert('habits', habit.toMap());
  }

  Future<void> updateHabit(Habit habit) async {
    final db = await AppDatabase.database;
    await db.update('habits', habit.toMap(), where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<void> deleteHabit(int habitId) async {
    final db = await AppDatabase.database;
    await db.delete('habits', where: 'id = ?', whereArgs: [habitId]);
  }
}
