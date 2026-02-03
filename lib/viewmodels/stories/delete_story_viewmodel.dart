import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:read_it/viewmodels/stories/story_list_viewmodel.dart';

import '../../../providers/api_providers.dart';
import '../refresh_ui/library_viewmodel.dart';

final deleteStoryViewModelProvider = StateNotifierProvider<DeleteStoryViewModel, DeleteStoryState>((ref) {
  return DeleteStoryViewModel(ref);
});

class DeleteStoryState {
  final AsyncValue<void> deleteStatus;
  final bool isLoading;
  final String? error;

  DeleteStoryState({
    this.deleteStatus = const AsyncData(null),
    this.isLoading = false,
    this.error,
  });

  DeleteStoryState copyWith({
    AsyncValue<void>? deleteStatus,
    bool? isLoading,
    String? error,
  }) {
    return DeleteStoryState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DeleteStoryViewModel extends StateNotifier<DeleteStoryState> {
  final Ref ref;

  DeleteStoryViewModel(this.ref) : super(DeleteStoryState());

  Future<void> deleteStory(int storyId, int userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(storyRepositoryProvider).deleteStory(storyId);
      state = state.copyWith(deleteStatus: const AsyncData(null), isLoading: false);
      ref.read(libraryViewModelProvider.notifier).refreshLibrary();
      ref.read(storyListViewModelProvider.notifier).refreshAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}