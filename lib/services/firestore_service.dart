import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/user.dart';
import 'package:flutter_rpg/models/vocation.dart';

class FirestoreService {
  static final usersRef = FirebaseFirestore.instance.collection('users');
  static final userDocRef = usersRef.doc(User().uid);
  static final skillRef = userDocRef.collection('skills').withConverter(
      fromFirestore: Skill.fromFirestore,
      toFirestore: (Skill v, _) => v.toFirestore());
  static final vocationRef = userDocRef.collection('vocations').withConverter(
      fromFirestore: Vocation.fromFirestore,
      toFirestore: (Vocation v, _) => v.toFirestore());
  static final charactersRef = userDocRef
      .collection('characters')
      .withConverter(
          fromFirestore: Character.fromFirestore,
          toFirestore: (Character c, _) => c.toFirestore());

// CHARACTERS

  // create a new character
  static Future<void> addCharacter(Character character) async {
    await charactersRef.doc(character.id).set(character);
  }

  // read all characters
  static Future<QuerySnapshot<Character>> getCharacters() async {
    return charactersRef.get();
  }

  // update a character
  static Future<void> updateCharacter(Character character) async {
    await charactersRef.doc(character.id).update({
      'stats': character.statsAsMap,
      'points': character.points,
      'activeSkillIds': character.activeSkillIds,
      'skills': character.skillIds,
      'isFave': character.isFave,
      'currentHealth': character.currentHealth,
      'currentMana': character.currentMana
    });
  }

  // delete a character
  static Future<void> deleteCharacter(Character character) async {
    await charactersRef.doc(character.id).delete();
  }

  // create an inventory item
  static Future<void> updateInventory(Character character) async {
    await charactersRef
        .doc(character.id)
        .update({'inventory': character.inventoryAsFormattedList});
  }

// VOCATIONS

  // create a new vocation
  static Future<void> addVocation(Vocation vocation) async {
    await vocationRef.doc(vocation.id).set(vocation);
  }

  // read all vocation
  static Future<QuerySnapshot<Vocation>> getVocations() async {
    return vocationRef.get();
  }

  // update a vocation
  static Future<void> updateVocation(Vocation vocation) async {
    await vocationRef.doc(vocation.id).update({
      'id': vocation.id,
      'name': vocation.name,
      'title': vocation.title,
      'description': vocation.description,
      'weapon': vocation.weapon,
      'ability': vocation.ability,
      'image': vocation.image
    });
  }

  // delete a vocation
  static Future<void> deleteVocation(Vocation vocation) async {
    await vocationRef.doc(vocation.id).delete();
  }

// SKILLS

// add a skill to a character
  static Future<void> updateCharacterSkills(
      Character character, List<String> skillIds) async {
    await charactersRef.doc(character.id).update({'skills': skillIds});
  }

// create a new skill
  static Future<void> addSkill(Skill skill) async {
    await skillRef.doc(skill.id).set(skill);
  }

  // read all skills
  static Future<QuerySnapshot<Skill>> getSkills() async {
    return skillRef.get();
  }

  // update a skill
  static Future<void> updateSkill(Skill skill) async {
    await skillRef.doc(skill.id).update({
      'id': skill.id,
      'name': skill.name,
      'image': skill.image,
    });
  }

  // delete a skill
  static Future<void> deleteSkill(Skill skill) async {
    await skillRef.doc(skill.id).delete();
  }
}
