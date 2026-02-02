import 'package:isar_community/isar.dart';

part 'offline_chapter.g.dart';

@collection
class OfflineChapter {
  Id id = Isar.autoIncrement;
  @Index()
  int storyId;
  @Index()
  int chapterId;
  String storyName;
  String chapterTitle;
  int orderNum;
  String content;
  DateTime downloadedAt;

  OfflineChapter({
    required this.storyId,
    required this.chapterId,
    required this.storyName,
    required this.chapterTitle,
    required this.orderNum,
    required this.content,
    required this.downloadedAt,
  });
}