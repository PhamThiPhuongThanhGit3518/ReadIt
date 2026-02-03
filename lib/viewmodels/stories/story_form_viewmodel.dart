import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:read_it/viewmodels/refresh_ui/library_viewmodel.dart';
import 'package:read_it/viewmodels/stories/story_detail_viewmodel.dart';
import 'package:read_it/viewmodels/stories/story_list_viewmodel.dart';

import '../../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';
import '../chapters/chapter_form_viewmodel.dart';
import '../chapters/chapter_list_viewmodel.dart';

class StoryFormState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final StoryResponse? response;

  StoryFormState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.response,
  });

  StoryFormState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
    StoryResponse? response,
  }) {
    return StoryFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
      response: response ?? this.response,
    );
  }
}

final storyFormViewModelProvider = StateNotifierProvider<StoryFormViewModel, StoryFormState>((ref) {
  return StoryFormViewModel(ref);
});

class StoryFormViewModel extends StateNotifier<StoryFormState> {
  final Ref ref;

  StoryFormViewModel(this.ref) : super(StoryFormState());

  Future<void> submitStory({
    int? storyId,
    required String title,
    required String description,
    File? poster,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      StoryResponse result;
      if (storyId != null && storyId != -1) {
        result = await ref.read(storyRepositoryProvider).updateStory(
          storyId: storyId,
          title: title,
          description: description,
          posterFile: poster,
        );
        ref.invalidate(chapterListProvider(storyId));
        ref.invalidate(storyDetailProvider(storyId));
      } else {
        result = await ref.read(storyRepositoryProvider).createStory(
          title: title,
          description: description,
          genres: [],
          posterFile: poster,
        );
      }
      state = state.copyWith(isLoading: false, isSuccess: true, response: result);

      ref.read(storyListViewModelProvider.notifier).refreshAll();
      ref.read(libraryViewModelProvider.notifier).refreshLibrary();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), isSuccess: false);
    }
  }
}