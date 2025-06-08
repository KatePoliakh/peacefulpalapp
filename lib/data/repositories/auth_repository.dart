import '../models/user_profile.dart';
import '../database/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<void> register(String email, String password) async {
    final db = await AppDatabase.database;
    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (existing.isNotEmpty) throw Exception('Пользователь уже существует');
    int userId = await db.insert('users', {
      'email': email,
      'password': password,
    });
    await _setCurrentUserId(userId);
  }

  Future<UserProfile> login(String email, String password) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isEmpty) throw Exception('Неверный email или пароль');
    final user = UserProfile.fromMap(result.first);
    await _setCurrentUserId(user.id!);
    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user_id');
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('current_user_id');
  }

  Future<void> _setCurrentUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_user_id', userId);
  }
}
