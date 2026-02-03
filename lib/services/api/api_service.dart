import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:read_it/models/dto/api_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.phongdaynai.id.vn/v1")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @POST("/auth/register")
  Future<UserDto> register(@Body() RegisterRequest request);

  @POST("/auth/login")
  Future<AuthResponse> login(@Body() LoginRequest request);

  @GET("/auth/me")
  Future<UserDto> getCurrentUser();


  @GET("/users/profile")
  Future<UserDto> getProfile();

  @PUT("/users/profile")
  Future<UserDto> updateProfile(@Body() UpdateProfileRequest request);


  @GET("/users")
  Future<AdminUsersResponse> getAllUsers();

  @PATCH("/users/{id}/role")
  Future<SetRoleResponse> setUserRole(
      @Path("id") int userId,
      @Body() SetRoleRequest request,
      );


  @MultiPart()
  @POST("/stories")
  Future<StoryResponse> createStory(
      @Part() String title,
      @Part() String description,
      @Part() List<String> genres,
      @Part(name: "poster") MultipartFile? posterFile,
      );

  @GET("/stories/me/favorites")
  Future<StoryListResponse> getFavoriteStories();

  @GET("/stories/user/{userId}")
  Future<StoryListResponse> getStoriesByUser(@Path("userId") int userId);

  @GET("/stories/me/progress")
  Future<StoryProgressResponse> getProgressStories();

  @GET("/stories/{storyId}/info")
  Future<StoryInfoResponse> getStoryInfo(@Path("storyId") int storyId);

  @GET("/stories")
  Future<StoryListResponse> searchStories(@Query("search") String keyword);

  @GET("/stories/top/new")
  Future<StoryListResponse> getNewStories();

  @GET("/stories/top/views")
  Future<StoryListResponse> getPopularStories();

  @POST("/stories/{id}/favorite")
  Future<FavoriteResponse> toggleFavorite(@Path("id") int id);

  @MultiPart()
  @POST("/stories/upload-chapter")
  Future<UploadChaptersResponse> uploadSingleChapter(
      @Part(name: "storyId") int storyId,
      @Part(name: "chapterTitle") String title,
      @Part(name: "orderNum") int orderNum,
      @Part(name: "chapterFile") MultipartFile chapterFile,
      );

  @GET("/stories/{storyId}/chapters")
  Future<ChapterListResponse> getChapterList(@Path("storyId") int storyId);

  @GET("/stories/personalized/chapters/:chapterId")
  Future<ChapterContentResponse> getChapterContent(@Path("chapterId") int chapterId);

    @GET("/stories/personalized/{storyId}/chapters/{orderNum}")
  Future<ChapterContentResponse> getChapterByNumber(
      @Path("storyId") int storyId,
      @Path("orderNum") int orderNum,
  );
  
  @DELETE('/stories/{storyId}')
  Future<CommonResponse> deleteStory(@Path("storyId") int storyId);

  @DELETE('/stories/chapters/{chapterId}')
  Future<CommonResponse> deleteChapter(@Path("chapterId") int chapterId);

  @DELETE('/stories/{storyId}/chapters/{orderNum}')
  Future<CommonResponse> deleteChapterByNumber(@Path("storyId") int storyId, @Path("orderNum") int orderNum);

  @MultiPart()
  @PATCH("/stories/{storyId}")
  Future<StoryResponse> updateStory(
      @Path("storyId") int storyId,
      @Part() String? title,
      @Part() String? description,
      @Part(name: "poster") MultipartFile? posterFile,
      );

  @MultiPart()
  @PATCH("/stories/{storyId}/chapters/{orderNum}")
  Future<CommonResponse> updateChapterByNumber(
      @Path("storyId") int storyId,
      @Path("orderNum") int orderNum,
      @Part(name: "title") String? title,
      @Part(name: "chapterFile") MultipartFile? chapterFile,
      );

  @MultiPart()
  @PATCH("/stories/chapters/{chapterId}")
  Future<CommonResponse> updateChapter(
      @Path("chapterId") int chapterId,
      @Part(name: "chapterTitle") String? title,
      @Part(name: "chapterFile") MultipartFile? chapterFile,
      );
}