import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:read_it/models/dto/api_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/api_providers.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<UserDto?>>((ref) {
  return AuthViewModel(ref);
});

class AuthViewModel extends StateNotifier<AsyncValue<UserDto?>> {
  final Ref ref;

  AuthViewModel(this.ref) : super(const AsyncValue.loading()) {
    _initAuth();
  }

  Future<void> _initAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userJson = prefs.getString('user_data');

      if (token != null && token.isNotEmpty) {
        if (userJson != null) {
          final cachedUser = UserDto.fromJson(jsonDecode(userJson));
          state = AsyncData(cachedUser);
        }
        final user = await ref.read(authRepositoryProvider).getCurrentUser();
        state = AsyncData(user);
        await prefs.setString('user_data', jsonEncode(user.toJson()));
      } else {
        state = const AsyncData(null);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(String username, String email, String password, String role) async {
    state = const AsyncLoading();
    try {
      final UserDto user = await ref.read(authRepositoryProvider).register(username, email, password, role);
      state = AsyncData(user);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(user.toJson()));
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final response = await ref.read(authRepositoryProvider).login(email, password);
      if (response.user != null && response.token != null) {
        state = AsyncData(response.user);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.token!);
        await prefs.setString('user_data', jsonEncode(response.user!.toJson()));
      } else {
        state = const AsyncData(null);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    state = const AsyncData(null);
  }
}

final currentUserProvider = FutureProvider<UserDto>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final userDataString = prefs.getString('user_data');

  if (userDataString != null) {
    return UserDto.fromJson(jsonDecode(userDataString));
  } else {
    final authRepo = ref.watch(authRepositoryProvider);
    final user = await authRepo.getCurrentUser();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
    return user;
  }
});