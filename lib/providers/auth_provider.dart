import 'package:flutter_riverpod/legacy.dart';
import '../database/models/user_table.dart';
import '../repositories/local/user_repository.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(this.repo) : super(null);

  final UserRepository repo;

  Future<bool> login(String phone, String password) async {
    final user = await repo.login(phone, password);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  Future<bool> register(String fullname, String phone, String password, int role) async {
    try{
      await repo.registerUser(fullname, phone, password, role);
      final loggedIn = await login(phone, password);
      return loggedIn;
    } catch (e) {
      print('Register error: $e');
      return false;
    }

  }

  void logout() {
    state = null;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref.watch(userRepositoryProvider));
});