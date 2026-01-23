import 'package:isar_community/isar.dart';

part 'history_table.g.dart';

@collection
class History {
  Id id = Isar.autoIncrement;
  late int userId;
  late int storyId;
  late DateTime viewedAt;
}