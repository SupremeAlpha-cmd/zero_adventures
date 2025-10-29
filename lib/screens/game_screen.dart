import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/models/story_model.dart';
import 'package:zero_adventures/providers/game_provider.dart';
import 'package:zero_adventures/widgets/character_sheet.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use context.watch to listen for changes in the GameProvider
    final game = context.watch<GameProvider>();
    final Scene? scene = game.currentScene;
    final storyTitle = game.currentStory?.title ?? 'Loading...';

    // Handle loading state
    if (scene == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // TODO: Add a confirmation dialog
            Navigator.pop(context);
          },
        ),
        title: Text(storyTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // TODO: Show hamburger menu
            },
          ),
        ],
      ),
      // Use a SafeArea to avoid the system UI (like notches)
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Story Text ---
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    scene.text,
                    style:  TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.6, // Line spacing
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Choices ---
              // Build a list of buttons from the scene's choices
              Column(
                children: scene.choices.map((choice) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      // Use a different style for choices
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FFFF), // Cyan
                        foregroundColor: Colors.black, // Black text
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        // When pressed, call makeChoice on the provider
                        context.read<GameProvider>().makeChoice(choice);
                      },
                      child: Text(choice.text),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      // --- Character FAB ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const CharacterSheet();
            },
          );
        },
        backgroundColor: const Color(0xFF00FFFF),
        child: const Icon(Icons.person, color: Colors.black),
      ),
    );
  }
}
