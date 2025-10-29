import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zero_adventures/models/story_model.dart';
import 'package:zero_adventures/models/player_model.dart';

class GameProvider with ChangeNotifier {
  Story? _currentStory;
  String? _currentSceneId;

  // Player Stats (matching screen (3).png)
  final PlayerStats _playerStats = PlayerStats(
    name: 'Elara the Sorceress',
    location: 'The Whispering Woods',
    avatarAsset: 'assets/images/elara_avatar.png', // Placeholder path
    currentHp: 85,
    maxHp: 100,
    currentMp: 60,
    maxMp: 100,
    strength: 12,
    dexterity: 18,
    intelligence: 25,
    charisma: 15,
  );

  // Player Inventory
  final List<Item?> _inventory = [
    Item(
      name: 'Health Potion',
      imageAsset: 'assets/images/potion.png',
    ), // Placeholder
    Item(
      name: 'Mana Potion',
      imageAsset: 'assets/images/mana_potion.png',
    ), // Placeholder
    null, // Empty slot
    null, // Empty slot
    null, // Empty slot
    null, // Empty slot
    null, // Empty slot
    null, // Empty slot
  ];

  // Player Relationships
  final List<NPC> _relationships = [
    NPC(
      name: 'Kaelen',
      title: 'the Elder',
      imageAsset: 'assets/images/kaelen_avatar.png', // Placeholder
      status: RelationshipStatus.Ally,
    ),
    NPC(
      name: 'Lyra',
      title: 'the Rogue',
      imageAsset: 'assets/images/lyra_avatar.png', // Placeholder
      status: RelationshipStatus.Neutral,
    ),
  ];

  // These are placeholders from your UI
  int _chronoshards = 500;
  int _storiesCompleted = 4;
  int _achievements = 27;

  // --- Getters ---
  Story? get currentStory => _currentStory;
  Scene? get currentScene {
    if (_currentStory == null || _currentSceneId == null) {
      return null;
    }
    return _currentStory!.scenes[_currentSceneId];
  }

  PlayerStats get playerStats => _playerStats;
  List<Item?> get inventory => _inventory;
  List<NPC> get relationships => _relationships;

  int get chronoshards => _chronoshards;
  int get storiesCompleted => _storiesCompleted;
  int get achievements => _achievements;

  // --- Methods ---

  /// Loads a story from a JSON asset file
  Future<void> loadStory(String storyAssetPath) async {
    try {
      // Load the JSON file from assets
      final String jsonString = await rootBundle.loadString(storyAssetPath);
      // Decode the JSON string into a Map
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Use our factory constructor to create a Story object
      _currentStory = Story.fromJson(storyAssetPath, jsonMap);
      _currentSceneId = _currentStory!.startSceneId;

      // Tell all listening widgets to rebuild
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading story: $e');
    }
  }

  /// Updates the game state based on a player's choice
  void makeChoice(Choice choice) {
    if (_currentStory != null) {
      _currentSceneId = choice.nextSceneId;

      // Check if we reached the end
      if (_currentSceneId == 'end_game') {
        _storiesCompleted++; // Increment stories completed
        // Here you could add logic to give achievements, etc.
      }

      notifyListeners();
    }
  }
}
