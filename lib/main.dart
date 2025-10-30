import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';
import 'package:zero_adventures/screens/category_screen.dart';
import 'package:zero_adventures/screens/game_screen.dart';
import 'package:zero_adventures/screens/main_shell.dart';
import 'package:zero_adventures/screens/settings_screen.dart';
import 'package:zero_adventures/screens/welcome_screen.dart';

void main() {
  runApp(
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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF12101B),
        primaryColor: const Color(0xFF00FFFF),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFFF),
          surface: Color(0xFF1A1726),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00FFFF),
            foregroundColor: Colors.black,
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
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1726),
          selectedItemColor: Color(0xFF00FFFF),
          unselectedItemColor: Colors.grey,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/app': (context) => const MainShell(),
        '/game': (context) => const GameScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
