import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero_adventures/models/story_model.dart';
import 'package:zero_adventures/providers/game_provider.dart';
import 'package:zero_adventures/widgets/character_sheet.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    final Scene? scene = game.currentScene;
    final storyTitle = game.currentStory?.title ?? 'Loading...';

    if (scene == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Check if the current scene is the end of the story
    final bool isGameOver = scene.choices.isEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Exit Game?'),
                  content: const Text(
                      'Are you sure you want to exit? Your progress will not be saved.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Exit'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.of(context).pop(); // Go back from the game screen
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        title: Text(storyTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // This could open a game menu in the future
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    scene.text,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // If it's game over, show the restart button, otherwise show choices
              if (isGameOver)
                _buildGameOver(context)
              else
                _buildChoices(context, scene.choices),
            ],
          ),
        ),
      ),
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

  // Widget for displaying the choices
  Widget _buildChoices(BuildContext context, List<Choice> choices) {
    return Column(
      children: choices.map((choice) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FFFF),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              context.read<GameProvider>().makeChoice(choice);
            },
            child: Text(choice.text),
          ),
        );
      }).toList(),
    );
  }

  // Widget for the game over screen
  Widget _buildGameOver(BuildContext context) {
    return Column(
      children: [
        const Text(
          'The End',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            // Restart the story using the provider
            context.read<GameProvider>().restartStory();
          },
          child: const Text('Restart'),
        ),
      ],
    );
  }
}
