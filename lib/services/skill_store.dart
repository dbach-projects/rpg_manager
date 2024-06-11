import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/services/firestore_service.dart';

class SkillStore extends ChangeNotifier {
  final List<Skill> _predefinedSkills = predefinedSkills;
  final List<Skill> _userdefinedSkills = [];

  List<Skill> get skills => [..._predefinedSkills, ..._userdefinedSkills];
  List<Skill> get userdefinedSkills => _userdefinedSkills;

  // SKILLS

  // initially fetch skills
  void fetchSkillsOnce() async {
    if (userdefinedSkills.isEmpty) {
      final snapshot = await FirestoreService.getSkills();

      for (var doc in snapshot.docs) {
        _userdefinedSkills.add(doc.data());
      }

      notifyListeners();
    }
  }

  // create skill
  Skill addSkill(Skill skill) {
    FirestoreService.addSkill(skill);
    _userdefinedSkills.add(skill);
    notifyListeners();
    return skill;
  }

  // remove skill
  void removeSkill(Skill skill) async {
    await FirestoreService.deleteSkill(skill);

    _userdefinedSkills.remove(skill);
    notifyListeners();
  }
}
