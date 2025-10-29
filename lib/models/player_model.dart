import 'package:flutter/material.dart';

class Player {
  String name;
  String location;
  int health;
  int maxHealth;
  int mana;
  int maxMana;
  int strength;
  int dexterity;
  int intelligence;
  int charisma;
  int chronoshards;
  List<Item> inventory;
  List<Relationship> relationships;
  String avatarUrl;

  Player({
    required this.name,
    required this.location,
    required this.health,
    required this.maxHealth,
    required this.mana,
    required this.maxMana,
    required this.strength,
    required this.dexterity,
    required this.intelligence,
    required this.charisma,
    this.chronoshards = 500, // Default value
    required this.inventory,
    required this.relationships,
    required this.avatarUrl,
  });
}

class Item {
  String name;
  String imageUrl;

  Item({
    required this.name,
    required this.imageUrl,
  });
}

class Relationship {
  String name;
  RelationshipStatus status;
  String imageUrl;

  Relationship({
    required this.name,
    required this.status,
    required this.imageUrl,
  });
}

enum RelationshipStatus {
  ally,
  neutral,
  enemy,
}
