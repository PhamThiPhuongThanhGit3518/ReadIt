import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';
import '../../providers/auth_providers.dart';
import 'refresh_ui/library_viewmodel.dart';

final chapterListProvider = FutureProvider.family.autoDispose<List<ChapterSummary>, int>(
      (ref, storyId) async {
    try {
      return await ref.watch(storyRepositoryProvider).getChapters(storyId);
    } catch (e, st) {
      throw Exception('Lỗi tải danh sách chapter: $e');
    }
  },
);

final chapterByOrderProvider = FutureProvider.family.autoDispose<ChapterDetail?, ({int storyId, int orderNum})>(
      (ref, arg) async {
    try {
      final response = await ref.watch(storyRepositoryProvider).getChapterByNumber(
        arg.storyId,
        arg.orderNum,
      );
      return response.data;
    } catch (e, st) {
      throw Exception('Lỗi tải nội dung chapter: $e');
    }
  },
);

final uploadChapterProvider = StateNotifierProvider<UploadChapterViewModel, UploadChapterState>(
      (ref) => UploadChapterViewModel(ref),
);

class UploadChapterState {
  final bool isLoading;
  final String? error;
  final bool success;

  UploadChapterState({
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  UploadChapterState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return UploadChapterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}

class UploadChapterViewModel extends StateNotifier<UploadChapterState> {
  final Ref ref;

  UploadChapterViewModel(this.ref) : super(UploadChapterState());

  Future<void> uploadChapter({
    required int storyId,
    required String title,
    required String content,
    required int orderNum,
  }) async {
    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      await ref.read(storyRepositoryProvider).uploadChapter(
        storyId: storyId,
        title: title,
        content: content,
        orderNum: orderNum,
      );

      state = state.copyWith(isLoading: false, success: true);
      final userId = ref.read(currentUserProvider).value?.id ?? -1;
      if (userId > 0) {
        ref.read(libraryViewModelProvider.notifier).refreshMyStories();
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), success: false);
    }
  }
}

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
  }) async {
    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      await ref.read(storyRepositoryProvider).deleteChapter(chapterId);
      state = state.copyWith(isLoading: false, success: true);
      final userId = ref.read(currentUserProvider).value?.id ?? -1;
      if (userId > 0) {
        ref.read(libraryViewModelProvider.notifier).refreshMyStories();
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), success: false);
    }
  }
}