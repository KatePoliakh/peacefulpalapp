import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/habit.dart';

class HabitFirestoreDataSource {
  final _db = FirebaseFirestore.instance;

  Future<List<Habit>> getHabits(String userId) async {
    final snapshot = await _db.collection("users").doc(userId).collection("habits").get();
    return snapshot.docs.map((doc) => Habit.fromMap(doc.id, doc.data())).toList();
  }

  Future<void> addHabit(String userId, Habit habit) async {
    await _db.collection("users").doc(userId).collection("habits").add(habit.toMap());
  }

  Future<void> updateHabit(String userId, Habit habit) async {
    await _db.collection("users").doc(userId).collection("habits").doc(habit.id).update(habit.toMap());
  }

  Future<void> deleteHabit(String userId, String habitId) async {
    await _db.collection("users").doc(userId).collection("habits").doc(habitId).delete();
  }
}
