import 'package:read_it/models/dto/api_dto.dart';
import 'package:read_it/services/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<UserDto> register(String username, String email, String password, String? role) async {
    final request = RegisterRequest(username: username, email: email, password: password, role: role);
    final userResponse = await apiService.register(request);
    await login(email, password);
    return userResponse;
  }

  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await apiService.login(request);

    if (response.token != null && response.user != null) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('auth_token', response.token!);

      final userJson = jsonEncode(response.user!.toJson());
      await prefs.setString('user_data', userJson);
    }
    return response;
  }

  Future<UserDto> getCurrentUser() async {
    return apiService.getCurrentUser();
  }
}