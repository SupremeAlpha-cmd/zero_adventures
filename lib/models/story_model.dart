/// Represents a single story scene.
class Scene {
  final String id;
  final String text;
  final List<Choice> choices;

  Scene({
    required this.id,
    required this.text,
    required this.choices,
  });

  /// Factory constructor to create a Scene from a JSON map.
  factory Scene.fromJson(String id, Map<String, dynamic> json) {
    var choicesList = (json['choices'] as List)
        .map((choiceJson) => Choice.fromJson(choiceJson as Map<String, dynamic>))
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

  Choice({
    required this.text,
    required this.nextSceneId,
  });

  /// Factory constructor to create a Choice from a JSON map.
  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'] as String,
      // Support both "nextSceneId" and "to" for choice navigation
      nextSceneId: json['nextSceneId'] ?? json['to'] as String,
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
    final sceneData = json['scenes'] ?? json['nodes'];
    if (sceneData == null) {
      throw Exception('Story has no scenes or node');
    }

    // Explicitly create a Map<String, Scene> to ensure type safety.
    final Map<String, Scene> sceneMap = {};
    (sceneData as Map).forEach((sceneId, sceneJson) {
      sceneMap[sceneId as String] =
          Scene.fromJson(sceneId as String, sceneJson as Map<String, dynamic>);
    });

    return Story(
      id: id,
      title: json['title'] as String,
      // Support both "startSceneId" and "start_node" for the starting scene
      startSceneId: json['startSceneId'] ?? json['start_node'] as String,
      scenes: sceneMap,
    );
  }
}
