import 'package:isar_community/isar.dart';

part 'download_table.g.dart';

@collection
class Download {
  Id id = Isar.autoIncrement;
  late int userId;
  late int storyId;
  late int chapterId;
  late String localPath;
}