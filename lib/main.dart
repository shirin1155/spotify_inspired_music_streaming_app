import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/login_navigate_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MusicStreamingApp());
}

class MusicStreamingApp extends StatelessWidget {
  const MusicStreamingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Music Streaming App',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
            const Color(0xFF121212),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const LoginScreen(),

        '/login': (context) =>
            const LoginNavigateScreen(),

        '/signup': (context) =>
            const SignUpScreen(),

        '/onboarding': (context) =>
            const OnBoardingScreen(),

        '/home': (context) =>
            const HomeScreen(),

        '/profile': (context) =>
            const ProfileScreen(showBottomNavigationBar: true),
      },
    );
  }
}