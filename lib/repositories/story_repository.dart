import 'dart:convert';
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

  Future<List<StorySummary>> getNewStories() async {
    final response = await apiService.getNewStories();
    return response.data ?? [];
  }

  Future<List<StorySummary>> getPopularStories() async {
    final response = await apiService.getPopularStories();
    return response.data ?? [];
  }

  Future<StoryDetail?> getStoryDetail(int storyId) async {
    final response = await apiService.getStoryInfo(storyId);
    return response.data;
  }

  Future<List<StorySummary>> getFavoriteStories() async {
    final response = await apiService.getFavoriteStories();
    return response.data ?? [];
  }

  Future<List<HistoryItem>> getProgressStories() async {
    final response = await apiService.getProgressStories();
    return response.data ?? [];
  }

  Future<List<StorySummary>> getStoriesByUser(int userId) async {
    try {
      print("Calling GET /api/stories/user/$userId");
      final response = await apiService.getStoriesByUser(userId);
      print("Raw response: ${response.toString()}");
      print("Success: ${response.success}, Data length: ${response.data?.length ?? 0}");
      if (response.data != null) {
        print("First story: ${response.data![0]}");
      }
      return response.data ?? [];
    } catch (e) {
      print("Error in getStoriesByUser: $e");
      if (e is DioException) {
        print("Backend message: ${e.response?.data}");
      }
      return [];
    }
  }


  Future<StoryResponse> createStory({
    required String title,
    required String description,
    required List<String> genres,
    File? posterFile,
  }) async {
    MultipartFile? multipartFile;
    if (posterFile != null) {
      multipartFile = await MultipartFile.fromFile(
        posterFile.path,
        filename: posterFile.path.split('/').last,
      );
    }
    return apiService.createStory(title, description, genres, multipartFile);
  }

  Future<FavoriteResponse> toggleFavorite(int storyId) async {
    return apiService.toggleFavorite(storyId);
  }

  Future<List<ChapterSummary>> getChapters(int storyId) async {
    final response = await apiService.getChapterList(storyId);
    return response.data ?? [];
  }

  Future<List<StorySummary>> searchStories(String keyword) async {
    final response = await apiService.searchStories(keyword);
    return response.data ?? [];
  }

  Future<ChapterContentResponse> getChapterByNumber(int storyId, int orderNum) async {
    return apiService.getChapterByNumber(storyId, orderNum);
  }

  Future<UploadChaptersResponse> uploadChapter({
    required int storyId,
    required String title,
    required String content,
    required int orderNum,
  }) async {
    final contentBytes = utf8.encode(content);

    final file = MultipartFile.fromBytes(
      contentBytes,
      filename: 'content.txt',
    );

    return apiService.uploadSingleChapter(
      storyId,
      title,
      orderNum,
      file,
    );
  }

  Future<CommonResponse> deleteStory(int storyId) async {
    return apiService.deleteStory(storyId);
  }

  Future<CommonResponse> deleteChapter(int chapterId) async {
    return apiService.deleteChapter(chapterId);
  }

  Future<CommonResponse> deleteChapterByNumber(int storyId, int orderNum) async {
    return apiService.deleteChapterByNumber(storyId, orderNum);
  }

  Future<StoryResponse> updateStory({
    required int storyId,
    String? title,
    String? description,
    File? posterFile,
  }) async {
    MultipartFile? multipartFile;
    if (posterFile != null) {
      multipartFile = await MultipartFile.fromFile(
        posterFile.path,
        filename: posterFile.path.split('/').last,
      );
    }
    return apiService.updateStory(storyId, title, description, multipartFile);
  }

  Future<CommonResponse> updateChapterByNumber({
    required int storyId,
    required int orderNum,
    String? title,
    String? content,
  }) async {
    MultipartFile? file;
    if (content != null) {
      final contentBytes = utf8.encode(content);
      file = MultipartFile.fromBytes(
        contentBytes,
        filename: 'content_updated.txt',
      );
    }
    return apiService.updateChapterByNumber(
      storyId,
      orderNum,
      title,
      file,
    );
  }

  Future<CommonResponse> updateChapter({
    required int chapterId,
    String? title,
    String? content,
  }) async {
    MultipartFile? file;
    if (content != null) {
      final contentBytes = utf8.encode(content);
      file = MultipartFile.fromBytes(
        contentBytes,
        filename: 'content_updated.txt',
      );
    }
    return apiService.updateChapter(chapterId, title, file);
  }

}