import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';

final chapterListProvider = FutureProvider.family.autoDispose<List<ChapterSummary>, int>(
      (ref, storyId) async {
    try {
      return await ref.watch(storyRepositoryProvider).getChapters(storyId);
    } catch (e, st) {
      throw Exception('Lỗi tải danh sách chapter: $e');
    }
  },
);