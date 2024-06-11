import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/inventory_item.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/services/firestore_service.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  get characters => _characters;

  // CHARACTER

  // initially fetch characters
  void fetchCharactersOnce() async {
    if (characters.isEmpty) {
      final snapshot = await FirestoreService.getCharacters();

      for (var doc in snapshot.docs) {
        _characters.add(doc.data());
      }

      notifyListeners();
    }
  }

  // create character
  Character addCharacter(Character character) {
    FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners();
    return character;
  }

  // update character
  Future<void> saveCharacter(Character character) async {
    await FirestoreService.updateCharacter(character);
    notifyListeners();
    return;
  }

  // remove character
  void removeCharacter(Character character) async {
    await FirestoreService.deleteCharacter(character);

    _characters.remove(character);
    notifyListeners();
  }

  // INVENTORY

  // Create inventory item
  void createInventoryItem(Character character, InventoryItem item) async {
    character.inventory.add(item);
    await FirestoreService.updateInventory(character);
    notifyListeners();
  }

  List<InventoryItem> getInventory(Character character) {
    return character.inventory;
  }

  // Delete inventory item
  void deleteInventoryItem(Character character, InventoryItem item) async {
    character.inventory.remove(item);
    await FirestoreService.updateInventory(character);
    notifyListeners();
  }

  // reorder inventory
  void reorderInventory(Character character, oldIndex, newIndex) {
    var inventory = character.inventory;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final InventoryItem item = inventory.removeAt(oldIndex);
    inventory.insert(newIndex, item);
    notifyListeners();
  }

  // SKILLS

//toggle skill
  void updateCharacterSkillsFirebase(
      Character character, List<String> skillIds) async {
    await FirestoreService.updateCharacterSkills(character, skillIds);

    notifyListeners();
  }

  //remove skill
  void removeSkill(Character character, Skill skill) {
    character.skillIds.remove(skill.id);
    notifyListeners();
  }
}
