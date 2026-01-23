
import 'package:isar_community/isar.dart';

part 'user_table.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  late String fullname;
  @Index(unique: true)
  late String phone;
  late String password;
  late int role;
}