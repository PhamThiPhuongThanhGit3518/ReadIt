import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:read_it/services/new_viewmodels/story_list_viewmodel.dart';

import '../../providers/api_providers.dart';
import 'refresh_ui/library_viewmodel.dart';

final deleteChapterViewModelProvider = StateNotifierProvider<DeleteChapterViewModel, DeleteChapterState>((ref) {
  return DeleteChapterViewModel(ref);
});

class DeleteChapterState {
  final AsyncValue<void> deleteStatus;
  final bool isLoading;
  final String? error;

  DeleteChapterState({
    this.deleteStatus = const AsyncData(null),
    this.isLoading = false,
    this.error,
  });

  DeleteChapterState copyWith({
    AsyncValue<void>? deleteStatus,
    bool? isLoading,
    String? error,
  }) {
    return DeleteChapterState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DeleteChapterViewModel extends StateNotifier<DeleteChapterState> {
  final Ref ref;

  DeleteChapterViewModel(this.ref) : super(DeleteChapterState());

  Future<void> deleteChapter(int chapterId, int storyId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(storyRepositoryProvider).deleteChapter(chapterId);
      state = state.copyWith(deleteStatus: const AsyncData(null), isLoading: false);
      // Refresh library để update My Stories (chapterCount)
      ref.read(libraryViewModelProvider.notifier).refreshLibrary();
      ref.read(storyListViewModelProvider.notifier).refreshAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}