import '../database/app_database.dart';
import '../models/user_profile.dart';

class AuthRepository {
  Future<void> register(String email, String password) async {
    final db = await AppDatabase.database;
    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (existing.isNotEmpty) {
      throw Exception('Такой пользователь уже существует');
    }
    await db.insert('users', {'email': email, 'password': password});
  }

  Future<UserProfile> login(String email, String password) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isEmpty) throw Exception('Неверный email или пароль');
    return UserProfile.fromMap(result.first);
  }
}
