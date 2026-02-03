import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';
import '../refresh_ui/library_viewmodel.dart';

final chapterByOrderProvider = FutureProvider.family<ChapterDetail?, ({int storyId, int orderNum})>(
      (ref, arg) async {
    try {
      final response = await ref.read(storyRepositoryProvider).getChapterByNumber(
        arg.storyId,
        arg.orderNum,
      );
      ref.read(libraryViewModelProvider.notifier).refreshHistory();
      return response.data;
    } catch (e, st) {
      throw Exception('Lỗi tải nội dung chapter: $e');
    }
  },
);