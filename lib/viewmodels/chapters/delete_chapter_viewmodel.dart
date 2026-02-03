import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../providers/api_providers.dart';
import '../refresh_ui/library_viewmodel.dart';
import '../stories/story_detail_viewmodel.dart';
import '../stories/story_list_viewmodel.dart';
import 'chapter_list_viewmodel.dart';

final deleteChapterProvider = StateNotifierProvider<DeleteChapterViewModel, DeleteChapterState>(
      (ref) => DeleteChapterViewModel(ref),
);

class DeleteChapterState {
  final bool isLoading;
  final String? error;
  final bool success;

  DeleteChapterState({
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  DeleteChapterState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return DeleteChapterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}

class DeleteChapterViewModel extends StateNotifier<DeleteChapterState> {
  final Ref ref;

  DeleteChapterViewModel(this.ref) : super(DeleteChapterState());

  Future<void> deleteChapter({
    required int chapterId,
    required int storyId,
  }) async {
    state = state.copyWith(isLoading: true, error: null, success: false);
    try {
      await ref.read(storyRepositoryProvider).deleteChapter(chapterId);
      ref.invalidate(chapterListProvider(storyId));
      ref.invalidate(storyDetailProvider(storyId));
      ref.read(libraryViewModelProvider.notifier).refreshLibrary();
      ref.read(storyListViewModelProvider.notifier).refreshAll();

      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), success: false);
    }
  }
}