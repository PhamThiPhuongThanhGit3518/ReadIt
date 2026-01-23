import 'package:isar_community/isar.dart';

part 'comment_table.g.dart';

@collection
class Comment {
  Id id = Isar.autoIncrement;
  late int storyId;
  late int userId;
  late String content;
  late DateTime createdAt;
}