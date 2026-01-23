
import 'package:isar_community/isar.dart';

part 'genre_table.g.dart';

@collection
class Genre {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String genreName;
}