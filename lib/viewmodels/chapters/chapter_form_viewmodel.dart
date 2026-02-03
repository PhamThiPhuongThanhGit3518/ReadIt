import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../providers/api_providers.dart';
import '../refresh_ui/library_viewmodel.dart';
import '../stories/story_detail_viewmodel.dart';
import '../stories/story_list_viewmodel.dart';
import 'chapter_detail_viewmodel.dart';
import 'chapter_list_viewmodel.dart';

class ChapterFormState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const ChapterFormState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  ChapterFormState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return ChapterFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

final chapterFormViewModelProvider = StateNotifierProvider<ChapterFormViewModel, ChapterFormState>((ref) {
  return ChapterFormViewModel(ref);
});

class ChapterFormViewModel extends StateNotifier<ChapterFormState> {
  final Ref ref;

  ChapterFormViewModel(this.ref) : super(const ChapterFormState());

  Future<void> submitChapter({
    required int storyId,
    required String title,
    required String content,
    required int orderNum,
    required bool isEdit,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final repo = ref.read(storyRepositoryProvider);

      if (isEdit) {
        await repo.updateChapterByNumber(
          storyId: storyId,
          orderNum: orderNum,
          title: title,
          content: content,
        );
      } else {
        await repo.uploadChapter(
          storyId: storyId,
          title: title,
          content: content,
          orderNum: orderNum,
        );
      }

      ref.invalidate(chapterListProvider(storyId));
      ref.invalidate(storyDetailProvider(storyId));
      ref.invalidate(
        chapterByOrderProvider((storyId: storyId, orderNum: orderNum)),
      );

      ref.read(libraryViewModelProvider.notifier).refreshMyStories();
      ref.read(storyListViewModelProvider.notifier).refreshAll();
      await Future.delayed(const Duration(milliseconds: 50));
      state = state.copyWith(isLoading: false, isSuccess: true);

    } catch (e) {

    }
  }
}
