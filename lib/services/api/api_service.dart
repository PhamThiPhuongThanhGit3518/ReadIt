import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:read_it/models/dto/api_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @POST("/v1/auth/register")
  Future<UserDto> register(@Body() RegisterRequest request);

  @POST("/v1/auth/login")
  Future<AuthResponse> login(@Body() LoginRequest request);

  @GET("/v1/auth/me")
  Future<UserDto> getCurrentUser();


  @GET("/v1/users/profile")
  Future<UserDto> getProfile();

  @PUT("/v1/users/profile")
  Future<UserDto> updateProfile(@Body() UpdateProfileRequest request);


  @GET("/v1/users")
  Future<AdminUsersResponse> getAllUsers();

  @PATCH("/v1/users/{id}/role")
  Future<SetRoleResponse> setUserRole(
      @Path("id") int userId,
      @Body() SetRoleRequest request,
      );


  @MultiPart()
  @POST("/v1/stories")
  Future<StoryResponse> createStory(
      @Part() String title,
      @Part() String description,
      @Part(name: "poster") MultipartFile? posterFile,
      );

  @GET("/v1/stories/me/favorites")
  Future<StoryListResponse> getFavoriteStories();

  @GET("/v1/stories/user/{userId}")
  Future<StoryListResponse> getStoriesByUser(@Path("userId") int userId);

  @GET("/v1/stories/me/progress")
  Future<StoryListResponse> getProgressStories();

  @PATCH("/v1/stories/{storyId}/view")
  Future<CommonResponse> incrementView(@Path("storyId") int storyId);

  @GET("/v1/stories/{storyId}/info")
  Future<StoryInfoResponse> getStoryInfo(@Path("storyId") int storyId);

  @GET("/v1/stories")
  Future<StoryListResponse> searchStories(@Query("search") String keyword);

  @GET("/v1/stories/top/new")
  Future<StoryListResponse> getNewStories();

  @GET("/v1/stories/top/views")
  Future<StoryListResponse> getPopularStories();

  @POST("/v1/stories/{id}/favorite")
  Future<FavoriteResponse> toggleFavorite(@Path("id") int id);

  @MultiPart()
  @POST("/v1/stories/upload-chapter")
  Future<UploadChaptersResponse> uploadSingleChapter(
      @Part(name: "storyId") int storyId,
      @Part(name: "chapterTitle") String title,
      @Part(name: "orderNum") int orderNum,
      @Part(name: "chapterFile") MultipartFile chapterFile,
      );

  @GET("/v1/stories/{storyId}/chapters")
  Future<ChapterListResponse> getChapterList(@Path("storyId") int storyId);

  @GET("/v1/stories/personalized/chapters/:chapterId")
  Future<ChapterContentResponse> getChapterContent(@Path("chapterId") int chapterId);

  @GET("/v1/stories/{storyId}/chapters/{orderNum}")
  Future<ChapterContentResponse> getChapterByNumber(
      @Path("storyId") int storyId,
      @Path("orderNum") int orderNum,
  );
  
  @DELETE('/v1/stories/{storyId}')
  Future<CommonResponse> deleteStory(@Path("storyId") int storyId);

  @DELETE('/v1/stories/chapters/{chapterId}')
  Future<CommonResponse> deleteChapter(@Path("chapterId") int chapterId);

  @DELETE('/v1/stories/{storyId}/chapters/{orderNum}')
  Future<CommonResponse> deleteChapterByNumber(@Path("storyId") int storyId, @Path("orderNum") int orderNum);
}