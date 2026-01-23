import 'package:isar_community/isar.dart';

part 'chapter_table.g.dart';

@collection
class Chapter {
  Id id = Isar.autoIncrement;
  late int storyId;
  late int chapterNumber;
  String? title;
  late String pdfUrl;
  late DateTime updatedAt;
}