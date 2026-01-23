import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../providers/providers.dart';
import '../models/user_table.dart';

final userDaoProvider = Provider<UserDao>((ref) => UserDaoImpl(ref));

abstract class UserDao {
  Future<void> insertUser(User user);
  Future<User?> getUserByPhone(String phone);
}

class UserDaoImpl implements UserDao {
  final Ref ref;

  UserDaoImpl(this.ref);

  Future<Isar> get _isar => ref.read(isarProvider.future);

  @override
  Future<void> insertUser(User user) async {
    final isar = await _isar;
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  @override
  Future<User?> getUserByPhone(String phone) async {
    final isar = await _isar;
    return await isar.users.where().phoneEqualTo(phone).findFirst();
  }
}