import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/views/author/create_new_story_screen.dart';
import 'package:read_it/views/author/edit_chapter_screen.dart';
import 'package:read_it/views/author/upload_chapter_screen.dart';
import 'package:read_it/views/reader/home_screen.dart';
import 'package:read_it/views/reader/library_screen.dart';
import 'package:read_it/views/reader/profile_screen.dart';
import 'package:read_it/views/reader/read_chapter_screen.dart';
import 'package:read_it/views/reader/story_detail_screen.dart';

import '../database/models/offline_chapter.dart';
import '../layout/main_wrapper.dart';
import '../views/login/sign_in_screen.dart';
import '../views/login/sign_up_screen.dart';
import '../views/reader/read_offline_screen.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final route = GoRouter(
    initialLocation: '/sign_in',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(path: '/sign_up',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(path: '/sign_in',
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/create_story/:storyId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final idString = state.pathParameters['storyId'];
          final id = int.tryParse(idString ?? '') ?? -1;
          return CreateNewStoryScreen(storyId: id);
        },
      ),
      GoRoute(
        path: '/edit_chapter/:storyId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final idString = state.pathParameters['storyId'];
          final id = int.tryParse(idString ?? '') ?? -1;
          return EditChapterScreen(storyId: id);
        },
      ),
      GoRoute(path: '/upload_chapter/:storyId/:chapterId',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final chapterNum = extra?['chapterNum'] as int?;
          return UploadChapterScreen(
            storyId: int.parse(state.pathParameters['storyId']!),
            chapterId: int.parse(state.pathParameters['chapterId']!),
            chapterNum: chapterNum ?? -1,
          );
        },
      ),
      GoRoute(
        path: '/read_offline',
        builder: (context, state) {
          final chapter = state.extra as OfflineChapter;
          return ReadOfflineScreen(chapter: chapter);
        },
      ),
      GoRoute(
        path: '/story_detail/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return StoryDetailScreen(storyId: id);
        },
      ),
      GoRoute(
        path: '/read_chapter/:storyId/:chapterNum',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final storyId = int.parse(state.pathParameters['storyId']!);
          final chapterNum = int.parse(state.pathParameters['chapterNum']!);
          return ReadChapterScreen(
            storyId: storyId,
            chapterNum: chapterNum,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainWrapper(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/library',
              builder: (context, state) => const LibraryScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ])
        ]
      )
    ]
  );
}