import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:isar_community/isar.dart';

import '../../../database/models/offline_chapter.dart';
import '../../../models/dto/api_dto.dart';
import '../../../providers/isar_providers.dart';

final offlineViewModelProvider = StateNotifierProvider<OfflineViewModel, AsyncValue<void>>((ref) {
  return OfflineViewModel(ref);
});

class OfflineViewModel extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  OfflineViewModel(this.ref) : super(const AsyncData(null));

  Future<void> downloadChapter(StoryDetail story, ChapterDetail chapter) async {
    state = const AsyncLoading();
    try {
      final isar = ref.read(isarProvider);

      final offlineItem = OfflineChapter(
        storyId: story.id ?? -1,
        chapterId: chapter.id,
        storyName: story.title ?? "Loading...",
        chapterTitle: chapter.title,
        orderNum: chapter.orderNum,
        content: chapter.content,
        downloadedAt: DateTime.now(),
      );

      await isar.writeTxn(() async {
        await isar.offlineChapters.put(offlineItem);
      });

      state = const AsyncData(null);
      ref.invalidate(offlineChaptersProvider);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteChapter(int isarId) async {
    final isar = ref.read(isarProvider);
    await isar.writeTxn(() async {
      await isar.offlineChapters.delete(isarId);
    });
    ref.invalidate(offlineChaptersProvider);
  }
}

final isDownloadedProvider = Provider.family<bool, int>((ref, chapterId) {
  final chapters = ref.watch(offlineChaptersProvider).value ?? [];
  return chapters.any((element) => element.chapterId == chapterId);
});

final offlineChaptersProvider = FutureProvider<List<OfflineChapter>>((ref) async {
  final isar = ref.watch(isarProvider);
  return isar.offlineChapters.where().sortByDownloadedAtDesc().findAll();
});