// repositories/story_repository.dart
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/dto/api_dto.dart';
import '../services/api/api_service.dart';

class StoryRepository {
  final ApiService apiService;
  StoryRepository(this.apiService);

  Future<List<StorySummary>> getStories({String? query}) async {
    final response = await apiService.searchStories(query ?? "");
    return response.data ?? [];
  }

  Future<StoryDetail?> getStoryDetail(int storyId) async {
    final response = await apiService.getStoryInfo(storyId);
    return response.data;
  }

  Future<StoryResponse> createStory({
    required String title,
    required String description,
    File? posterFile,
  }) async {
    MultipartFile? multipartFile;
    if (posterFile != null) {
      multipartFile = await MultipartFile.fromFile(
        posterFile.path,
        filename: posterFile.path.split('/').last,
      );
    }
    return apiService.createStory(title, description, multipartFile);
  }

  Future<List<ChapterSummary>> getChapters(int storyId) async {
    final response = await apiService.getChapterList(storyId);
    return response.data ?? [];
  }

  Future<List<StorySummary>> searchStories(String keyword) async {
    final response = await apiService.searchStories(keyword);
    return response.data ?? [];
  }

  Future<ChapterContentResponse> getChapterContent(int chapterId) async {
    return apiService.getChapterContent(chapterId);
  }

  Future<UploadChaptersResponse> uploadChapter({
    required int storyId,
    required String title,
    required String content,
    required int orderNum,
  }) async {
    final file = await MultipartFile.fromBytes(
      content.codeUnits,
      filename: '$orderNum.txt',
    );
    return apiService.uploadChapters(
      storyId,
      [file],
    );
  }
}