import 'package:shared_preferences/shared_preferences.dart';
import '../database/app_database.dart';
import '../models/user_profile.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthRepository {
  Future<void> register(String email, String password) async {
    final db = await AppDatabase.database;

    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (existing.isNotEmpty) throw Exception('User already exists');

    String salt = BCrypt.gensalt();
    final hashedPassword = BCrypt.hashpw(password, salt);

    int userId = await db.insert('users', {
      'email': email,
      'password': hashedPassword,
    });

    await _setCurrentUserId(userId);
    await _setAnonymous(false);
  }

  Future<UserProfile> login(String email, String password) async {
    final db = await AppDatabase.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isEmpty) throw Exception('Invalid email or password');

    final userData = result.first;
    final storedHash = userData['password'] as String;

    if (!BCrypt.checkpw(password, storedHash)) {
      throw Exception('Invalid email or password');
    }

    final user = UserProfile.fromMap(userData);
    await _setCurrentUserId(user.id!);
    await _setAnonymous(false);
    return user;
  }

  Future<void> loginAnonymously() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_user_id', -1);
    await prefs.setBool('is_anonymous', true);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user_id');
    await prefs.remove('is_anonymous');
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('current_user_id');
  }

  Future<bool> isAnonymous() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_anonymous') ?? false;
  }

  Future<void> _setCurrentUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_user_id', userId);
  }

  Future<void> _setAnonymous(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_anonymous', value);
  }
}
