import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/dto/api_dto.dart';
import '../providers/api_providers.dart';

final storyListProvider = StateNotifierProvider<StoryListViewModel, AsyncValue<List<StorySummary>>>((ref) {
  return StoryListViewModel(ref);
});

class StoryListViewModel extends StateNotifier<AsyncValue<List<StorySummary>>> {
  final Ref ref;
  StoryListViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchStories();
  }

  Future<void> fetchStories({String? query}) async {
    state = const AsyncValue.loading();
    try {
      final stories = await ref.read(storyRepositoryProvider).getStories(query: query);
      state = AsyncValue.data(stories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      return fetchStories();
    }

    state = const AsyncValue.loading();
    try {
      final results = await ref.read(storyRepositoryProvider).searchStories(query);
      state = AsyncValue.data(results);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final createStoryProvider = StateNotifierProvider<CreateStoryViewModel, AsyncValue<StoryResponse?>>((ref) {
  return CreateStoryViewModel(ref);
});

class CreateStoryViewModel extends StateNotifier<AsyncValue<StoryResponse?>> {
  final Ref ref;
  CreateStoryViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> create(String title, String description, File? image) async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(storyRepositoryProvider).createStory(
        title: title,
        description: description,
        posterFile: image,
      );
      state = AsyncValue.data(result);
      ref.read(storyListProvider.notifier).fetchStories();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final storyDetailProvider = FutureProvider.family<StoryDetail?, int>((ref, id) async {
  return ref.watch(storyRepositoryProvider).getStoryDetail(id);
});

final chapterListProvider = FutureProvider.family<List<ChapterSummary>, int>((ref, id) async {
  return ref.watch(storyRepositoryProvider).getChapters(id);
});

final chapterDetailProvider = FutureProvider.family<ChapterDetail?, int>((ref, chapterId) async {
  final response = await ref.watch(storyRepositoryProvider).getChapterContent(chapterId);
  return response.data;
});

final uploadChapterProvider = StateNotifierProvider<UploadChapterViewModel, AsyncValue<void>>((ref) {
  return UploadChapterViewModel(ref);
});

class UploadChapterViewModel extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  UploadChapterViewModel(this.ref) : super(const AsyncData(null));

  Future<void> upload({
    required int storyId,
    required String title,
    required String content,
    required int orderNum,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(storyRepositoryProvider).uploadChapter(
        storyId: storyId,
        title: title,
        content: content,
        orderNum: orderNum,
      );
      state = const AsyncData(null);

      ref.invalidate(chapterListProvider(storyId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}