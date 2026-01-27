import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/daos/user_dao.dart';
import '../../database/models/user_table.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(userDaoProvider));
});

class UserRepository {
  final UserDao userDao;

  UserRepository(this.userDao);

  Future<bool> registerUser(String fullname, String phone, String password, int role) async {
    final existing = await userDao.getUserByPhone(phone);
    if (existing != null) return false;

    final user = User()
      ..fullname = fullname
      ..phone = phone
      ..password = password
      ..role = role;

    await userDao.insertUser(user);
    return true;
  }

  Future<User?> login(String phone, String password) async {
    final user = await userDao.getUserByPhone(phone);
    if (user != null && user.password == password) return user;
    return null;
  }
}

