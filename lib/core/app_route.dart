import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/views/author/create_new_story_screen.dart';
import 'package:read_it/views/author/upload_chapter_screen.dart';
import 'package:read_it/views/reader/home_screen.dart';
import 'package:read_it/views/reader/library_screen.dart';
import 'package:read_it/views/reader/profile_screen.dart';
import 'package:read_it/views/reader/read_chapter_screen.dart';
import 'package:read_it/views/reader/story_detail_screen.dart';

import '../layout/main_wrapper.dart';
import '../views/login/sign_in_screen.dart';
import '../views/login/sign_up_screen.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final route = GoRouter(
    initialLocation: '/sign_up',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(path: '/sign_up',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(path: '/sign_in',
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(path: '/create_story',
        builder: (context, state) => CreateNewStoryScreen(),
      ),
      GoRoute(path: '/upload_chapter',
        builder: (context, state) => UploadChapterScreen(),
      ),
      GoRoute(path: '/story_detail',
        builder: (context, state) => StoryDetailScreen(),
      ),
      GoRoute(path: '/read_chapter',
        builder: (context, state) => ReadChapterScreen(),
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