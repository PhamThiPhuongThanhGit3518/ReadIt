import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:read_it/services/new_viewmodels/story_list_viewmodel.dart';

import '../../models/dto/api_dto.dart';
import '../../providers/api_providers.dart';
import 'refresh_ui/library_viewmodel.dart';

final createStoryViewModelProvider = StateNotifierProvider<CreateStoryViewModel, CreateStoryState>((ref) {
  return CreateStoryViewModel(ref);
});

class CreateStoryState {
  final AsyncValue<StoryResponse?> story;
  final bool isLoading;
  final String? error;

  CreateStoryState({
    this.story = const AsyncData(null),
    this.isLoading = false,
    this.error,
  });

  CreateStoryState copyWith({
    AsyncValue<StoryResponse?>? story,
    bool? isLoading,
    String? error,
  }) {
    return CreateStoryState(
      story: story ?? this.story,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CreateStoryViewModel extends StateNotifier<CreateStoryState> {
  final Ref ref;

  CreateStoryViewModel(this.ref) : super(CreateStoryState());

  Future<void> createStory(String title, String description, File? poster) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await ref.read(storyRepositoryProvider).createStory(
        title: title,
        description: description,
        posterFile: poster,
      );
      state = state.copyWith(story: AsyncData(result), isLoading: false);
      ref.read(storyListViewModelProvider.notifier).refreshAll();
      ref.read(libraryViewModelProvider.notifier).refreshLibrary();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}