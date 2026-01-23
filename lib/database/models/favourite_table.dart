
import 'package:isar_community/isar.dart';

part 'favourite_table.g.dart';

@collection
class Favorite {
  Id id = Isar.autoIncrement;
  late int userId;
  late int storyId;
}