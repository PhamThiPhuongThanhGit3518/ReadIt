import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../models/dto/api_dto.dart';
import '../../../providers/api_providers.dart';
import '../refresh_ui/library_viewmodel.dart';

final storyDetailViewModelProvider = StateNotifierProvider<StoryDetailViewModel, StoryDetailState>((ref) {
  return StoryDetailViewModel(ref);
});

class StoryDetailState {
  final AsyncValue<StoryDetail?> story;
  final bool isLoading;
  final String? error;

  StoryDetailState({
    this.story = const AsyncData(null),
    this.isLoading = false,
    this.error,
  });

  StoryDetailState copyWith({
    AsyncValue<StoryDetail?>? story,
    bool? isLoading,
    String? error,
  }) {
    return StoryDetailState(
      story: story ?? this.story,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class StoryDetailViewModel extends StateNotifier<StoryDetailState> {
  final Ref ref;

  StoryDetailViewModel(this.ref) : super(StoryDetailState());

  Future<void> loadStoryDetail(int storyId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final story = await ref.read(storyRepositoryProvider).getStoryDetail(storyId);
      state = state.copyWith(story: AsyncData(story), isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> toggleFavorite(int storyId) async {
    try {
      await ref.read(storyRepositoryProvider).toggleFavorite(storyId);
      ref.read(libraryViewModelProvider.notifier).refreshLibrary();
      ref.invalidate(storyDetailProvider);
      await loadStoryDetail(storyId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final storyDetailProvider = FutureProvider.family.autoDispose<StoryDetail?, int>(
      (ref, storyId) async {
    try {
      return await ref.watch(storyRepositoryProvider).getStoryDetail(storyId);
    } catch (e, st) {
      throw Exception('Lỗi tải chi tiết truyện: $e');
    }
  },
);