// Enum to define relationship status
enum RelationshipStatus { Ally, Neutral, Enemy }

class PlayerStats {
  final String name;
  final String location;
  final String avatarAsset; // Path to avatar image
  final int currentHp;
  final int maxHp;
  final int currentMp;
  final int maxMp;
  final int strength;
  final int dexterity;
  final int intelligence;
  final int charisma;

  PlayerStats({
    required this.name,
    required this.location,
    required this.avatarAsset,
    required this.currentHp,
    required this.maxHp,
    required this.currentMp,
    required this.maxMp,
    required this.strength,
    required this.dexterity,
    required this.intelligence,
    required this.charisma,
  });
}

class Item {
  final String name;
  final String imageAsset; // Path to item image

  Item({required this.name, required this.imageAsset});
}

class NPC {
  final String name;
  final String title;
  final String imageAsset; // Path to NPC avatar
  final RelationshipStatus status;

  NPC({
    required this.name,
    required this.title,
    required this.imageAsset,
    required this.status,
  });
}
