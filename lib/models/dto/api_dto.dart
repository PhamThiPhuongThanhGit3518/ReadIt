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
  final int? storyId;
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
  final int? id;
  final String? authorName;
  final String? title;
  @JsonKey(name: 'viewCount')
  final int? viewCount;
  @JsonKey(name: 'chapterCount')
  final int? chapterCount;
  final String? coverImagePath;
  final DateTime? lastUpdateAt;

  StorySummary({
    required this.id,
    this.title,
    this.viewCount,
    this.chapterCount,
    this.coverImagePath,
    required this.authorName,
    this.lastUpdateAt,
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
  final int? id;
  final String? title;
  final String? authorName;
  final String? description;
  final int? chapterCount;
  final int? viewCount;
  final int? favoriteCount;
  final String? coverLink;
  final String? status;
  final DateTime? createdAt;
  final DateTime? lastUpdateAt;
  final List<String>? genres;

  StoryDetail({
    required this.id,
    this.title,
    this.authorName,
    this.description,
    required this.chapterCount,
    required this.viewCount,
    required this.favoriteCount,
    this.coverLink,
    this.genres,
    this.status,
    this.createdAt,
    this.lastUpdateAt,
  });

  factory StoryDetail.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailFromJson(json);
}

@JsonSerializable()
class FavoriteResponse {
  final bool success;
  final bool isFavorited;
  final String message;

  FavoriteResponse({
    required this.success,
    required this.isFavorited,
    required this.message,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);
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
  final int? id;
  final int? orderNum;
  final String? title;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  ChapterSummary({
    this.id,
    this.orderNum,
    this.title,
    this.createdAt,
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
  final String? title;

  UploadedChapter({required this.chapterId, this.title});

  factory UploadedChapter.fromJson(Map<String, dynamic> json) =>
      _$UploadedChapterFromJson(json);
}

@JsonSerializable()
class CommonResponse {
  final bool success;
  final String message;

  CommonResponse({required this.success, required this.message});

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);
}

@JsonSerializable()
class StoryProgressResponse {
  final bool success;
  final List<HistoryItem>? data;

  StoryProgressResponse({required this.success, this.data});

  factory StoryProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryProgressResponseFromJson(json);
}

@JsonSerializable()
class HistoryItem {
  final int? storyId;
  final String storyTitle;
  final String? coverImagePath;
  final String? authorName;
  final int? lastChapterId;
  final int? lastChapterOrder;
  final String? lastChapterTitle;
  final String? lastReadAt;
  final int? totalChapters;
  final String? coverLink;

  HistoryItem({
    required this.storyId,
    required this.storyTitle,
    this.coverImagePath,
    this.authorName,
    this.lastChapterId,
    this.lastChapterOrder,
    this.lastChapterTitle,
    this.lastReadAt,
    this.totalChapters,
    this.coverLink,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemFromJson(json);
}