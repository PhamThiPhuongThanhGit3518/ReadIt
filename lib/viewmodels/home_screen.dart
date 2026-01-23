import 'package:flutter_riverpod/legacy.dart';

class HomeNotifier extends StateNotifier<String> {
  HomeNotifier() : super('');

  void updateSearch(String text) {
    state = text;
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, String>((ref) => HomeNotifier());