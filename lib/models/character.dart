import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/inventory_item.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Character with Stats {
  // constructor
  Character({
    required this.vocationId,
    required this.name,
    required this.slogan,
    required this.id,
  });

  //fields
  final List<InventoryItem> _inventory = [];
  final List<String> _skillIds = [];
  final List<String> _activeSkillIds = [];
  final String vocationId;
  final String name;
  final String slogan;
  final String id;
  bool _isFave = false;
  int _currentHealth = 0;
  int _currentMana = 0;

  //getters
  bool get isFave => _isFave;
  int get currentHealth => _currentHealth;
  int get currentMana => _currentMana;
  List<String> get skillIds => _skillIds;
  List<String> get activeSkillIds => _activeSkillIds;
  List<InventoryItem> get inventory => _inventory;
  List<Map<String, dynamic>> get inventoryAsFormattedList =>
      inventory.map((item) => item.inventoryItemAsMap).toList();

  //methods
  void toggleActiveSkill(String skillId) {
    if (activeSkillIds.contains(skillId)) {
      activeSkillIds.remove(skillId);
    } else {
      activeSkillIds.add(skillId);
    }
  }

  void toggleIsFave() {
    _isFave = !_isFave;
  }

  bool toggleSkillId(String skillId) {
    if (!skillIds.contains(skillId)) {
      _skillIds.add(skillId);
      return true;
    } else {
      _skillIds.remove(skillId);
      return false;
    }
  }

  void increaseCurrentHealth() {
    _currentHealth++;
  }

  void decreaseCurrentHealth() {
    if (_currentHealth > 0) {
      _currentHealth--;
    }
  }

  void setCurrentHealth(int health) {
    _currentHealth = health;
  }

  void increaseCurrentMana() {
    _currentMana++;
  }

  void decreaseCurrentMana() {
    if (_currentMana > 0) {
      _currentMana--;
    }
  }

  void setCurrentMana(int mana) {
    _currentMana = mana;
  }

  // character for firebase (map)
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'slogan': slogan,
      'isFave': isFave,
      'vocationId': vocationId,
      'skills': skillIds,
      'activeSkillIds': activeSkillIds,
      'stats': statsAsMap,
      'points': points,
      'currentMana': currentMana,
      'currentHealth': currentHealth,
    };
  }

  // character from firestore
  factory Character.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    // get data from snapshot
    final data = snapshot.data()!;

    // make character instance
    Character character = Character(
        vocationId: data['vocationId'],
        name: data['name'],
        slogan: data['slogan'],
        id: snapshot.id);

    // update skills
    if (data['skills'] != null) {
      for (var id in data['skills']) {
        character.toggleSkillId(id);
      }
    }

    if (data['activeSkills'] != null) {
      for (var id in data['activeSkills']) {
        character.toggleActiveSkill(id);
      }
    }

    // update inventory
    if (data['inventory'] != null) {
      for (Map<String, dynamic> inventoryItem in data['inventory']) {
        character.inventory.add(InventoryItem(
            name: inventoryItem['name'],
            id: inventoryItem["id"],
            quantity: inventoryItem["quantity"]));
      }
    }

    // set isFave
    if (data['isFave'] == true) {
      character.toggleIsFave();
    }

    // assign stats and points
    character.setStats(points: data['points'], stats: data['stats']);

    // set current health
    character.setCurrentHealth(data['currentHealth']);

    // set current mana
    character.setCurrentMana(data['currentMana']);

    print('returning character: $character');

    return character;
  }

  @override
  String toString() {
    return 'name: $name';
  }
}
