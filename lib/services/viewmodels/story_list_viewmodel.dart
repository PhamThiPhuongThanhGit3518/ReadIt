import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';

final storyListViewModelProvider = StateNotifierProvider<StoryListViewModel, StoryListState>((ref) {
  return StoryListViewModel(ref);
});

class StoryListState {
  final AsyncValue<List<StorySummary>> stories;
  final AsyncValue<List<StorySummary>> newStories;
  final AsyncValue<List<StorySummary>> popularStories;

  StoryListState({
    this.stories = const AsyncLoading(),
    this.newStories = const AsyncLoading(),
    this.popularStories = const AsyncLoading(),
  });

  StoryListState copyWith({
    AsyncValue<List<StorySummary>>? stories,
    AsyncValue<List<StorySummary>>? newStories,
    AsyncValue<List<StorySummary>>? popularStories,
  }) {
    return StoryListState(
      stories: stories ?? this.stories,
      newStories: newStories ?? this.newStories,
      popularStories: popularStories ?? this.popularStories,
    );
  }
}

class StoryListViewModel extends StateNotifier<StoryListState> {
  final Ref ref;

  StoryListViewModel(this.ref) : super(StoryListState()) {
    fetchStories();
  }

  Future<void> fetchStories({String? query}) async {
    state = state.copyWith(stories: const AsyncLoading());
    try {
      final stories = await ref.read(storyRepositoryProvider).getStories(query: query);
      state = state.copyWith(stories: AsyncData(stories));
    } catch (e, st) {
      state = state.copyWith(stories: AsyncError(e, st));
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      return fetchStories();
    }

    state = state.copyWith(stories: const AsyncLoading());
    try {
      final results = await ref.read(storyRepositoryProvider).searchStories(query);
      state = state.copyWith(stories: AsyncData(results));
    } catch (e, st) {
      state = state.copyWith(stories: AsyncError(e, st));
    }
  }

  Future<void> fetchNewStories() async {
    state = state.copyWith(newStories: const AsyncLoading());
    try {
      final newStories = await ref.read(storyRepositoryProvider).getNewStories();
      state = state.copyWith(newStories: AsyncData(newStories));
    } catch (e, st) {
      state = state.copyWith(newStories: AsyncError(e, st));
    }
  }

  Future<void> fetchPopularStories() async {
    state = state.copyWith(popularStories: const AsyncLoading());
    try {
      final popularStories = await ref.read(storyRepositoryProvider).getPopularStories();
      state = state.copyWith(popularStories: AsyncData(popularStories));
    } catch (e, st) {
      state = state.copyWith(popularStories: AsyncError(e, st));
    }
  }

  Future<void> refreshAll() async {
    await fetchStories();
    await fetchNewStories();
    await fetchPopularStories();
  }
}