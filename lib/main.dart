import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';
import 'package:zero_adventures/screens/game_screen.dart';
import 'package:zero_adventures/screens/main_shell.dart';
import 'package:zero_adventures/screens/settings_screen.dart';
import 'package:zero_adventures/screens/welcome_screen.dart';

void main() {
  runApp(
    // Wrap the entire app in a ChangeNotifierProvider
    // This makes the GameProvider available to all screens
    ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: const ZeroAdventuresApp(),
    ),
  );
}

class ZeroAdventuresApp extends StatelessWidget {
  const ZeroAdventuresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zero Adventures',
      debugShowCheckedModeBanner: false,
      // Define a dark theme that matches your mockups
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF12101B), // Dark bg
        primaryColor: const Color(0xFF00FFFF), // Cyan accent
        fontFamily: 'Roboto', // Or any font you prefer
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFFF), // Cyan
          surface: Color(0xFF1A1726), // Darker surface
        ),
        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00FFFF), // Cyan
            foregroundColor: Colors.black, // Black text
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Bottom Nav Bar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1726),
          selectedItemColor: Color(0xFF00FFFF),
          unselectedItemColor: Colors.grey,
        ),

        // App Bar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      // Define the app's routes
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(), // screen (4).png
        '/app': (context) => const MainShell(), // The app with bottom nav
        '/game': (context) => const GameScreen(), // screen (10).png
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
