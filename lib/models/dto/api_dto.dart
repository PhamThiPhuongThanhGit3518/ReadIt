import 'package:json_annotation/json_annotation.dart';

part 'api_dto.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String username;
  final String email;
  final String password;
  final String? role;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    this.role,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final String? token;
  final UserDto? user;

  AuthResponse({this.token, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@JsonSerializable()
class UserDto {
  final int? id;
  final String? username;
  final String? email;
  final String? role;
  final DateTime? createdAt;

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@JsonSerializable()
class UpdateProfileRequest {
  final String? username;
  final String? email;

  UpdateProfileRequest({this.username, this.email});

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}

@JsonSerializable()
class CreateStoryRequest {
  final String title;
  final String description;

  CreateStoryRequest({required this.title, required this.description});

  Map<String, dynamic> toJson() => _$CreateStoryRequestToJson(this);
}

@JsonSerializable()
class StoryResponse {
  final bool success;
  final StoryData? data;

  StoryResponse({required this.success, this.data});

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);
}

@JsonSerializable()
class StoryData {
  final int storyId;
  final String? posterFilename;
  final String? posterLink;

  StoryData({
    required this.storyId,
    this.posterFilename,
    this.posterLink,
  });

  factory StoryData.fromJson(Map<String, dynamic> json) =>
      _$StoryDataFromJson(json);
}

@JsonSerializable()
class StoryListResponse {
  final bool success;
  final List<StorySummary>? data;

  StoryListResponse({required this.success, this.data});

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryListResponseFromJson(json);
}

@JsonSerializable()
class StorySummary {
  final int id;
  final String title;
  final int? viewCount;
  final int? chapterCount;
  final String? posterLink;

  StorySummary({
    required this.id,
    required this.title,
    this.viewCount,
    this.chapterCount,
    this.posterLink,
  });

  factory StorySummary.fromJson(Map<String, dynamic> json) =>
      _$StorySummaryFromJson(json);
}

@JsonSerializable()
class StoryInfoResponse {
  final bool success;
  final StoryDetail? data;

  StoryInfoResponse({required this.success, this.data});

  factory StoryInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryInfoResponseFromJson(json);
}

@JsonSerializable()
class StoryDetail {
  final int id;
  final String title;
  final String description;
  final int chapterCount;
  final int viewCount;
  final String? posterLink;
  final DateTime? createdAt;

  StoryDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.chapterCount,
    required this.viewCount,
    this.posterLink,
    this.createdAt,
  });

  factory StoryDetail.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailFromJson(json);
}


@JsonSerializable()
class ChapterListResponse {
  final bool success;
  final List<ChapterSummary>? data;

  ChapterListResponse({required this.success, this.data});

  factory ChapterListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterListResponseFromJson(json);
}

@JsonSerializable()
class ChapterSummary {
  final int id;
  final int orderNum;
  final String title;

  ChapterSummary({
    required this.id,
    required this.orderNum,
    required this.title,
  });

  factory ChapterSummary.fromJson(Map<String, dynamic> json) =>
      _$ChapterSummaryFromJson(json);
}

@JsonSerializable()
class ChapterContentResponse {
  final bool success;
  final ChapterDetail? data;

  ChapterContentResponse({required this.success, this.data});

  factory ChapterContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterContentResponseFromJson(json);
}

@JsonSerializable()
class ChapterDetail {
  final int id;
  final int orderNum;
  final String title;
  final String content;

  ChapterDetail({
    required this.id,
    required this.orderNum,
    required this.title,
    required this.content,
  });

  factory ChapterDetail.fromJson(Map<String, dynamic> json) =>
      _$ChapterDetailFromJson(json);
}


@JsonSerializable()
class AdminUsersResponse {
  final List<UserDto> data;

  AdminUsersResponse({required this.data});

  factory AdminUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminUsersResponseFromJson(json);
}

@JsonSerializable()
class SetRoleRequest {
  final String newRole;

  SetRoleRequest({required this.newRole});

  Map<String, dynamic> toJson() => _$SetRoleRequestToJson(this);
}

@JsonSerializable()
class SetRoleResponse {
  final int id;
  final String username;
  final String role;

  SetRoleResponse({
    required this.id,
    required this.username,
    required this.role,
  });

  factory SetRoleResponse.fromJson(Map<String, dynamic> json) =>
      _$SetRoleResponseFromJson(json);
}

@JsonSerializable()
class UploadChaptersResponse {
  final bool success;
  final String message;
  final List<UploadedChapter>? data;

  UploadChaptersResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UploadChaptersResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadChaptersResponseFromJson(json);
}

@JsonSerializable()
class UploadedChapter {
  final int chapterId;
  final String title;

  UploadedChapter({required this.chapterId, required this.title});

  factory UploadedChapter.fromJson(Map<String, dynamic> json) =>
      _$UploadedChapterFromJson(json);
}