import '../datasources/habit_firestore_data_source.dart';
import '../models/habit.dart';

class HabitRepository {
  final HabitFirestoreDataSource dataSource;

  HabitRepository(this.dataSource);

  Future<List<Habit>> getHabits(String userId) => dataSource.getHabits(userId);

  Future<void> addHabit(String userId, Habit habit) => dataSource.addHabit(userId, habit);

  Future<void> updateHabit(String userId, Habit habit) => dataSource.updateHabit(userId, habit);

  Future<void> deleteHabit(String userId, String habitId) => dataSource.deleteHabit(userId, habitId);
}
