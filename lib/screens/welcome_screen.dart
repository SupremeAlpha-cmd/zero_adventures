import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Simple dark gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2741), Color(0xFF12101B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              const Text(
                'Zero Adventures',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Choose your path across movies, books, and anime. Your story awaits.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F37C9), // Blue button
                  foregroundColor: Colors.white,
                ),
                child: const Text('Choose Your Path'),
                onPressed: () {
                  // Navigate to the main app and remove this screen
                  // from the back stack.
                  Navigator.pushReplacementNamed(context, '/app');
                },
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
