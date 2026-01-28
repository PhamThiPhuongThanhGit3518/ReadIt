import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_it/repositories/story_repository.dart';
import 'package:read_it/services/api/api_service.dart';
import 'package:read_it/services/api/dio_client.dart';
import 'package:read_it/repositories/auth_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiServiceProvider));
});

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepository(ref.watch(apiServiceProvider));
});