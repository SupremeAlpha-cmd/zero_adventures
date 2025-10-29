import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/providers/game_provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zero Adventures'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // TODO: Build your category buttons here

            // --- TEST BUTTON TO START STORY ---
            // This is a temporary button to test our game logic
            Center(
              child: ElevatedButton(
                child: const Text('Interstellar Odyssey'),
                onPressed: () {
                  // Get the provider and tell it to load our story
                  context.read<GameProvider>().loadStory(
                    'lib/assets/stories/interstellar_odyssey.json',
                  );

                  // Navigate to the game screen
                  Navigator.pushNamed(context, '/game');
                },
              ),
            ),

            // --- END TEST BUTTON ---
            const SizedBox(height: 34),
            const Text(
              'Top Rated',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // TODO: Build your horizontal list of top-rated stories
            const SizedBox(height: 24),
            const Text(
              'Latest Release',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // TODO: Build your horizontal list of latest releases
          ],
        ),
      ),
    );
  }
}
