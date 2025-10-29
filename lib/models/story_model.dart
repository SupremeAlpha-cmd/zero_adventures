

/// Represents a single story scene.
class Scene {
  final String id;
  final String text;
  final List<Choice> choices;
  // You could add more fields here later, like background_image, music_track, etc.

  Scene({
    required this.id,
    required this.text,
    required this.choices,
  });

  /// Factory constructor to create a Scene from a JSON map.
  factory Scene.fromJson(String id, Map<String, dynamic> json) {
    // Read the list of choices and convert them to Choice objects
    var choicesList = (json['choices'] as List)
        .map((choiceJson) => Choice.fromJson(choiceJson))
        .toList();

    return Scene(
      id: id,
      text: json['text'] as String,
      choices: choicesList,
    );
  }
}

/// Represents a single choice the player can make.
class Choice {
  final String text;
  final String nextSceneId;
  // You could add more fields here, like stat_changes, item_required, etc.

  Choice({
    required this.text,
    required this.nextSceneId,
  });

  /// Factory constructor to create a Choice from a JSON map.
  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'] as String,
      nextSceneId: json['nextSceneId'] as String,
    );
  }
}

/// Represents an entire story, which is a collection of scenes.
class Story {
  final String id;
  final String title;
  final String startSceneId;
  final Map<String, Scene> scenes;

  Story({
    required this.id,
    required this.title,
    required this.startSceneId,
    required this.scenes,
  });

  /// Factory constructor to create a Story from a JSON map.
  factory Story.fromJson(String id, Map<String, dynamic> json) {
    // Read the scenes map and convert each entry into a Scene object
    var sceneMap = (json['scenes'] as Map<String, dynamic>).map(
      (sceneId, sceneJson) => MapEntry(
        sceneId,
        Scene.fromJson(sceneId, sceneJson as Map<String, dynamic>),
      ),
    );

    return Story(
      id: id,
      title: json['title'] as String,
      startSceneId: json['startSceneId'] as String,
      scenes: sceneMap,
    );
  }
}