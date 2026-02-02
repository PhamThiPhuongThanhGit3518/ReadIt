// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  token: json['token'] as String?,
  user: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num?)?.toInt(),
  username: json['username'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'role': instance.role,
  'createdAt': instance.createdAt?.toIso8601String(),
};

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  username: json['username'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{'username': instance.username, 'email': instance.email};

CreateStoryRequest _$CreateStoryRequestFromJson(Map<String, dynamic> json) =>
    CreateStoryRequest(
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CreateStoryRequestToJson(CreateStoryRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };

StoryResponse _$StoryResponseFromJson(Map<String, dynamic> json) =>
    StoryResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : StoryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryResponseToJson(StoryResponse instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

StoryData _$StoryDataFromJson(Map<String, dynamic> json) => StoryData(
  storyId: (json['storyId'] as num).toInt(),
  posterFilename: json['posterFilename'] as String?,
  posterLink: json['posterLink'] as String?,
);

Map<String, dynamic> _$StoryDataToJson(StoryData instance) => <String, dynamic>{
  'storyId': instance.storyId,
  'posterFilename': instance.posterFilename,
  'posterLink': instance.posterLink,
};

StoryListResponse _$StoryListResponseFromJson(Map<String, dynamic> json) =>
    StoryListResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StorySummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoryListResponseToJson(StoryListResponse instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

StorySummary _$StorySummaryFromJson(Map<String, dynamic> json) => StorySummary(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  viewCount: (json['viewCount'] as num?)?.toInt(),
  chapterCount: (json['chapterCount'] as num?)?.toInt(),
  coverImagePath: json['coverImagePath'] as String?,
);

Map<String, dynamic> _$StorySummaryToJson(StorySummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'viewCount': instance.viewCount,
      'chapterCount': instance.chapterCount,
      'coverImagePath': instance.coverImagePath,
    };

StoryInfoResponse _$StoryInfoResponseFromJson(Map<String, dynamic> json) =>
    StoryInfoResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : StoryDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryInfoResponseToJson(StoryInfoResponse instance) =>
    <String, dynamic>{'success': instance.success, 'data': instance.data};

StoryDetail _$StoryDetailFromJson(Map<String, dynamic> json) => StoryDetail(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  chapterCount: (json['chapterCount'] as num).toInt(),
  viewCount: (json['viewCount'] as num).toInt(),
  favoriteCount: (json['favoriteCount'] as num?)?.toInt(),
  coverLink: json['coverLink'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$StoryDetailToJson(StoryDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'chapterCount': instance.chapterCount,
      'viewCount': instance.viewCount,
      'favoriteCount': instance.favoriteCount,
      'coverLink': instance.coverLink,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    FavoriteResponse(
      success: json['success'] as bool,
      isFavorited: json['isFavorited'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'isFavorited': instance.isFavorited,
      'message': instance.message,
    };

ChapterListResponse _$ChapterListResponseFromJson(Map<String, dynamic> json) =>
    ChapterListResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ChapterSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterListResponseToJson(
  ChapterListResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

ChapterSummary _$ChapterSummaryFromJson(Map<String, dynamic> json) =>
    ChapterSummary(
      id: (json['id'] as num).toInt(),
      orderNum: (json['orderNum'] as num).toInt(),
      title: json['title'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ChapterSummaryToJson(ChapterSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNum': instance.orderNum,
      'title': instance.title,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

ChapterContentResponse _$ChapterContentResponseFromJson(
  Map<String, dynamic> json,
) => ChapterContentResponse(
  success: json['success'] as bool,
  data: json['data'] == null
      ? null
      : ChapterDetail.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChapterContentResponseToJson(
  ChapterContentResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

ChapterDetail _$ChapterDetailFromJson(Map<String, dynamic> json) =>
    ChapterDetail(
      id: (json['id'] as num).toInt(),
      orderNum: (json['orderNum'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChapterDetailToJson(ChapterDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNum': instance.orderNum,
      'title': instance.title,
      'content': instance.content,
    };

AdminUsersResponse _$AdminUsersResponseFromJson(Map<String, dynamic> json) =>
    AdminUsersResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminUsersResponseToJson(AdminUsersResponse instance) =>
    <String, dynamic>{'data': instance.data};

SetRoleRequest _$SetRoleRequestFromJson(Map<String, dynamic> json) =>
    SetRoleRequest(newRole: json['newRole'] as String);

Map<String, dynamic> _$SetRoleRequestToJson(SetRoleRequest instance) =>
    <String, dynamic>{'newRole': instance.newRole};

SetRoleResponse _$SetRoleResponseFromJson(Map<String, dynamic> json) =>
    SetRoleResponse(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$SetRoleResponseToJson(SetRoleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'role': instance.role,
    };

UploadChaptersResponse _$UploadChaptersResponseFromJson(
  Map<String, dynamic> json,
) => UploadChaptersResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => UploadedChapter.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UploadChaptersResponseToJson(
  UploadChaptersResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

UploadedChapter _$UploadedChapterFromJson(Map<String, dynamic> json) =>
    UploadedChapter(
      chapterId: (json['chapterId'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$UploadedChapterToJson(UploadedChapter instance) =>
    <String, dynamic>{'chapterId': instance.chapterId, 'title': instance.title};

CommonResponse _$CommonResponseFromJson(Map<String, dynamic> json) =>
    CommonResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CommonResponseToJson(CommonResponse instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

StoryProgressResponse _$StoryProgressResponseFromJson(
  Map<String, dynamic> json,
) => StoryProgressResponse(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StoryProgressResponseToJson(
  StoryProgressResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) => HistoryItem(
  storyId: (json['storyId'] as num).toInt(),
  storyTitle: json['storyTitle'] as String,
  coverImagePath: json['coverImagePath'] as String?,
  authorName: json['authorName'] as String?,
  lastChapterId: (json['lastChapterId'] as num?)?.toInt(),
  lastChapterOrder: (json['lastChapterOrder'] as num?)?.toInt(),
  lastChapterTitle: json['lastChapterTitle'] as String?,
  lastReadAt: json['lastReadAt'] as String?,
  totalChapters: (json['totalChapters'] as num?)?.toInt(),
  coverLink: json['coverLink'] as String?,
);

Map<String, dynamic> _$HistoryItemToJson(HistoryItem instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'storyTitle': instance.storyTitle,
      'coverImagePath': instance.coverImagePath,
      'authorName': instance.authorName,
      'lastChapterId': instance.lastChapterId,
      'lastChapterOrder': instance.lastChapterOrder,
      'lastChapterTitle': instance.lastChapterTitle,
      'lastReadAt': instance.lastReadAt,
      'totalChapters': instance.totalChapters,
      'coverLink': instance.coverLink,
    };
