import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero_adventures/providers/game_provider.dart';
import 'package:zero_adventures/providers/theme_provider.dart';
import 'package:zero_adventures/screens/welcome_screen.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF6200EE),
  scaffoldBackgroundColor: const Color(0xFFF7F7F7),
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF6200EE),
    secondary: Color(0xFF03DAC6),
    surface: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6200EE),
      foregroundColor: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF6200EE),
    unselectedItemColor: Colors.grey,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF00FFFF),
  scaffoldBackgroundColor: const Color(0xFF12101B),
  fontFamily: 'Roboto',
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF00FFFF),
    surface: Color(0xFF1A1726),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF00FFFF),
      foregroundColor: Colors.black,
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
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider(sharedPreferences)),
      ],
      child: const ZeroAdventuresApp(),
    ),
  );
}

class ZeroAdventuresApp extends StatelessWidget {
  const ZeroAdventuresApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Zero Adventures',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const WelcomeScreen(),
    );
  }
}
