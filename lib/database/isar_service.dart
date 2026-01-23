import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models/chapter_table.dart';
import 'models/comment_table.dart';
import 'models/download_table.dart';
import 'models/favourite_table.dart';
import 'models/genre_table.dart';
import 'models/history_table.dart';
import 'models/story_table.dart';
import 'models/user_table.dart';

class IsarService {
  Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        UserSchema,
        StorySchema,
        ChapterSchema,
        GenreSchema,
        CommentSchema,
        FavoriteSchema,
        DownloadSchema,
        HistorySchema,
      ],
      directory: dir.path,
    );

    print("Isar initialized successfully.");
    return _isar!;
  }

  Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
      _isar = null;
    }
  }
}