import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/dto/api_dto.dart';
import '../providers/api_providers.dart';
import 'auth_viewmodel.dart';

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

final favoriteStoriesProvider = FutureProvider<List<StorySummary>>((ref) async {
  return ref.watch(storyRepositoryProvider).getFavoriteStories();
});

final progressStoriesProvider = FutureProvider<List<StorySummary>>((ref) async {
  return ref.watch(storyRepositoryProvider).getProgressStories();
});

final storiesByUserProvider = FutureProvider.family<List<StorySummary>, int>((ref, userId) async {
  if (userId <= 0) {
    return [];
  }

  try {
    final response = await ref.watch(storyRepositoryProvider).getStoriesByUser(userId);
    return response;
  } catch (e) {
    debugPrint('Lỗi getStoriesByUser: $e');
    return [];
  }
});

final storyDetailViewModelProvider = StateNotifierProvider<StoryDetailViewModel, AsyncValue<StoryDetail?>>((ref) {
  return StoryDetailViewModel(ref);
});

final storyDetailProvider = FutureProvider.family<StoryDetail?, int>((ref, id) async {
  final repo = ref.watch(storyRepositoryProvider);
  return repo.getStoryDetail(id);
});

class StoryDetailViewModel extends StateNotifier<AsyncValue<StoryDetail?>> {
  final Ref ref;
  StoryDetailViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> toggleFavorite(int storyId) async {
    try {
      await ref.read(storyRepositoryProvider).toggleFavorite(storyId);
      await ref.refresh(favoriteStoriesProvider.future);

      ref.invalidate(storyDetailProvider(storyId));
      ref.invalidate(popularStoriesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final chapterListProvider = FutureProvider.family<List<ChapterSummary>, int>((ref, id) async {
  return ref.watch(storyRepositoryProvider).getChapters(id);
});

final chapterByOrderProvider = FutureProvider.family<ChapterDetail?, ({int storyId, int orderNum})>((ref, arg) async {
  final repo = ref.watch(storyRepositoryProvider);
  final response = await repo.getChapterByNumber(arg.storyId, arg.orderNum);
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

final newStoriesProvider = FutureProvider<List<StorySummary>>((ref) async {
  return ref.watch(storyRepositoryProvider).getNewStories();
});

final popularStoriesProvider = FutureProvider<List<StorySummary>>((ref) async {
  return ref.watch(storyRepositoryProvider).getPopularStories();
});

final deleteStoryProvider = StateNotifierProvider<DeleteStoryViewModel, AsyncValue<void>>((ref) {
  return DeleteStoryViewModel(ref);
});

class DeleteStoryViewModel extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  DeleteStoryViewModel(this.ref) : super(const AsyncValue.data(null));

  Future<void> delete(int storyId, int userId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(storyRepositoryProvider).deleteStory(storyId);
      ref.invalidate(storiesByUserProvider(userId));
      ref.invalidate(popularStoriesProvider);
      ref.invalidate(newStoriesProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

