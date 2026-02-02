import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:read_it/providers/api_providers.dart';
import 'package:read_it/services/new_viewmodels/auth_viewmodel.dart';

import '../../../models/dto/api_dto.dart';

final libraryViewModelProvider = StateNotifierProvider<LibraryViewModel, LibraryState>((ref) {
  return LibraryViewModel(ref);
});

class LibraryState {
  final AsyncValue<List<StorySummary>> myStories;
  final AsyncValue<List<StorySummary>> favorites;
  final AsyncValue<List<StorySummary>> offline;
  final AsyncValue<List<HistoryItem>> history;

  LibraryState({
    this.myStories = const AsyncLoading(),
    this.favorites = const AsyncLoading(),
    this.offline = const AsyncLoading(),
    this.history = const AsyncLoading(),
  });

  LibraryState copyWith({
    AsyncValue<List<StorySummary>>? myStories,
    AsyncValue<List<StorySummary>>? favorites,
    AsyncValue<List<StorySummary>>? offline,
    AsyncValue<List<HistoryItem>>? history,
  }) {
    return LibraryState(
      myStories: myStories ?? this.myStories,
      favorites: favorites ?? this.favorites,
      offline: offline ?? this.offline,
      history: history ?? this.history,
    );
  }
}

class LibraryViewModel extends StateNotifier<LibraryState> {
  final Ref ref;

  LibraryViewModel(this.ref) : super(LibraryState()) {
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = ref.read(currentUserProvider).value?.id ?? -1;

    if (userId <= 0) {
      state = state.copyWith(
        myStories: const AsyncData([]),
        favorites: const AsyncData([]),
        offline: const AsyncData([]),
        history: const AsyncData([]),
      );
      return;
    }

    try {
      final myStories = await ref.read(storyRepositoryProvider).getStoriesByUser(userId);
      state = state.copyWith(myStories: AsyncData(myStories));
    } catch (e, st) {
      state = state.copyWith(myStories: AsyncError(e, st));
    }

    try {
      final favorites = await ref.read(storyRepositoryProvider).getFavoriteStories();
      state = state.copyWith(favorites: AsyncData(favorites));
    } catch (e, st) {
      state = state.copyWith(favorites: AsyncError(e, st));
    }

    try {
      final historyItems = await ref.read(storyRepositoryProvider).getProgressStories();
      state = state.copyWith(history: AsyncData(historyItems));
    } catch (e, st) {
      state = state.copyWith(history: AsyncError(e, st));
    }
    state = state.copyWith(offline: const AsyncData([]));
  }

  Future<void> refreshLibrary() async {
    await _loadData();
  }

  Future<void> refreshMyStories() async {
    final userId = ref.read(currentUserProvider).value?.id ?? -1;
    if (userId <= 0) return;

    try {
      final myStories = await ref.read(storyRepositoryProvider).getStoriesByUser(userId);
      state = state.copyWith(myStories: AsyncData(myStories));
    } catch (e, st) {
      state = state.copyWith(myStories: AsyncError(e, st));
    }
  }

  Future<void> refreshFavorites() async {
    try {
      final favorites = await ref.read(storyRepositoryProvider).getFavoriteStories();
      state = state.copyWith(favorites: AsyncData(favorites));
    } catch (e, st) {
      state = state.copyWith(favorites: AsyncError(e, st));
    }
  }

  Future<void> refreshHistory() async {
    try {
      final historyItems = await ref.read(storyRepositoryProvider).getProgressStories();
      state = state.copyWith(history: AsyncData(historyItems));
    } catch (e, st) {
      state = state.copyWith(history: AsyncError(e, st));
    }
  }

  Future<void> refreshOffline() async {
    state = state.copyWith(offline: const AsyncData([]));
  }

  Future<void> toggleFavorite(int storyId) async {
    try {
      await ref.read(storyRepositoryProvider).toggleFavorite(storyId);
      await refreshFavorites();
      await refreshMyStories();
    } catch (e, st) {
    }
  }

  Future<void> onStoryCreated() async {
    await refreshMyStories();
    await refreshLibrary();
  }

  Future<void> onChapterUploaded(int storyId) async {
    await refreshMyStories();
    await refreshLibrary();
  }

  Future<void> onStoryDeleted(int storyId) async {
    await refreshMyStories();
    await refreshLibrary();
  }

  Future<void> onChapterDeleted(int storyId) async {
    await refreshMyStories();
    await refreshLibrary();
  }
}