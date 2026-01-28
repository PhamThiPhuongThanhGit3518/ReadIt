import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:read_it/models/dto/api_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @POST("/api/auth/register")
  Future<UserDto> register(@Body() RegisterRequest request);

  @POST("/api/auth/login")
  Future<AuthResponse> login(@Body() LoginRequest request);

  @GET("/api/auth/me")
  Future<UserDto> getCurrentUser();


  @GET("/api/users/profile")
  Future<UserDto> getProfile();

  @PUT("/api/users/profile")
  Future<UserDto> updateProfile(@Body() UpdateProfileRequest request);


  @GET("/api/users")
  Future<AdminUsersResponse> getAllUsers();

  @PATCH("/api/users/{id}/role")
  Future<SetRoleResponse> setUserRole(
      @Path("id") int userId,
      @Body() SetRoleRequest request,
      );


  @MultiPart()
  @POST("/api/stories")
  Future<StoryResponse> createStory(
      @Part() String title,
      @Part() String description,
      @Part(name: "poster") MultipartFile? posterFile,
      );

  @GET("/api/stories/{storyId}/info")
  Future<StoryInfoResponse> getStoryInfo(@Path("storyId") int storyId);

  @GET("/api/stories")
  Future<StoryListResponse> searchStories(@Query("search") String keyword);


  @MultiPart()
  @POST("/api/stories/upload-chapters")
  Future<UploadChaptersResponse> uploadChapters(
      @Part() int storyId,
      @Part(name: "chapters") List<MultipartFile> chapterFiles,
  );

  @GET("/api/stories/{storyId}/chapters")
  Future<ChapterListResponse> getChapterList(@Path("storyId") int storyId);

  @GET("/api/stories/chapters/{chapterId}")
  Future<ChapterContentResponse> getChapterContent(@Path("chapterId") int chapterId);

  @GET("/api/stories/{storyId}/chapters/{orderNum}")
  Future<ChapterContentResponse> getChapterByNumber(
      @Path("storyId") int storyId,
      @Path("orderNum") int orderNum,
  );
}