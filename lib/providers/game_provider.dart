import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zero_adventures/models/story_model.dart';
import 'package:zero_adventures/models/player_model.dart';

class GameProvider with ChangeNotifier {
  Story? _currentStory;
  String? _currentSceneId;

  final Player _player = Player(
    name: 'Elara the Sorceress',
    location: 'The Whispering Woods',
    avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/elara_avatar.png?alt=media&token=89938194-d2c7-4336-860c-829871f65427',
    health: 85,
    maxHealth: 100,
    mana: 60,
    maxMana: 100,
    strength: 12,
    dexterity: 18,
    intelligence: 25,
    charisma: 15,
    chronoshards: 500, // Added the missing chronoshards property
    inventory: [
      Item(name: 'Health Potion', imageUrl: 'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/potion.png?alt=media&token=18b53d53-4a00-4103-91b5-14498e7db828'),
      Item(name: 'Mana Potion', imageUrl: 'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/mana_potion.png?alt=media&token=c27384a2-8957-41e9-8378-b1c4323204e3'),
    ],
    relationships: [
      Relationship(
        name: 'Kaelen, the Elder',
        status: RelationshipStatus.ally,
        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/kaelen_avatar.png?alt=media&token=10996b34-8c8c-44a6-88d3-3b3209d846c9',
      ),
      Relationship(
        name: 'Lyra, the Rogue',
        status: RelationshipStatus.neutral,
        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/zero-adventures-42749.appspot.com/o/lyra_avatar.png?alt=media&token=8679ef1c-8d35-4239-8199-2d334de96245',
      ),
    ],
  );

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

  Player get player => _player;
  int get storiesCompleted => _storiesCompleted;
  int get achievements => _achievements;

  // --- Methods ---

  Future<void> loadStory(String storyAssetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(storyAssetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      _currentStory = Story.fromJson(storyAssetPath, jsonMap);
      _currentSceneId = _currentStory!.startSceneId;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading story: $e');
    }
  }

  void makeChoice(Choice choice) {
    if (_currentStory != null) {
      if (_currentStory!.scenes.containsKey(choice.nextSceneId)) {
        _currentSceneId = choice.nextSceneId;
      } else {
        _currentSceneId = null;
      }

      if (choice.nextSceneId == 'end_game') {
        _storiesCompleted++;
      }

      notifyListeners();
    }
  }

  void restartStory() {
    if (_currentStory != null) {
      _currentSceneId = _currentStory!.startSceneId;
      notifyListeners();
    }
  }

  void useHealthPotion() {
    final healthPotion = _player.inventory.firstWhere((item) => item.name == 'Health Potion');
    if (healthPotion != null) {
      _player.health = (_player.health + 25).clamp(0, _player.maxHealth);
      _player.inventory.remove(healthPotion);
      notifyListeners();
    }
  }
}
