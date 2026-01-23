import 'package:isar_community/isar.dart';

import 'genre_table.dart';

part 'story_table.g.dart';

@collection
class Story {
  Id id = Isar.autoIncrement;
  late int authorId;
  late String title;
  String? coverImage;
  String? description;
  int views = 0;
  int favoritesCount = 0;
  late DateTime createdAt;
  late int status;

  final genres = IsarLinks<Genre>();
}