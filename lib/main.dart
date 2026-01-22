import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_it/core/app_route.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF101922),
          colorScheme: const ColorScheme.dark(
            surface: const Color(0xFF192633),
            onSurface: const Color(0xFF8AA4C0),
            primary: const Color(0xFF137BE4),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF)
            ),
            displayMedium: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF)
            ),
            displaySmall: TextStyle(
              fontSize: 14,
              color: Color(0xFFFFFFFF)
            ),
          )
      ),
      routerConfig: AppRoute.route,
    );
  }
}
