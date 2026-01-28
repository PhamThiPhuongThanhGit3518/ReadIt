import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dto/api_dto.dart';
import 'api_providers.dart';

final currentUserProvider = FutureProvider<UserDto>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  final localData = prefs.getString('user_data');

  if (localData != null) {
    return UserDto.fromJson(jsonDecode(localData));
  } else {
    final authRepo = ref.watch(authRepositoryProvider);
    final user = await authRepo.getCurrentUser();

    await prefs.setString('user_data', jsonEncode(user.toJson()));
    return user;
  }
});