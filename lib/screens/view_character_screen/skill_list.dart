import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/choose_skills_screen/choose_skills_screen.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/skill_store.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/shared/styled_icon_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late final Vocation vocation;
  late List<String> characterSkillIds;
  late List<String> vocationSkillIds;
  late List<Skill> allSkills;
  List<Skill> vocationSkills = [];
  List<Skill> customSkills = [];
  List<Skill> userCreatedSkills = [];

  @override
  void initState() {
    userCreatedSkills = Provider.of<SkillStore>(context, listen: false).skills;
    vocation = Provider.of<VocationStore>(context, listen: false)
        .vocations
        .firstWhere((element) => widget.character.vocationId == element.id);
    characterSkillIds = widget.character.skillIds;
    vocationSkillIds = vocation.skillIds;
    allSkills = Provider.of<SkillStore>(context, listen: false).skills;

    // gets skills specifically assigned to this character
    for (var id in characterSkillIds) {
      var skill = allSkills.firstWhere((element) => element.id == id);
      customSkills.add(skill);
    }

    // gets skills available for this characters vocation (class)
    for (var id in vocationSkillIds) {
      var skill = allSkills.firstWhere((element) => element.id == id);
      vocationSkills.add(skill);
    }

    // set default selected skill
    if (widget.character.skillIds.isEmpty) {
      widget.character.activeSkillIds.add(allSkills[0].id);
    } else {
      widget.character.activeSkillIds.add(allSkills.first.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withOpacity(.5),
        child: Column(
          children: [
            const StyledText('These skills are based on your class.'),
            const SizedBox(
              height: 20,
            ),

            //vocation based skills
            Wrap(
              alignment: WrapAlignment.start,
              children: vocationSkills.map((skill) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.character.toggleActiveSkill(skill.id);
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(2),
                        color:
                            widget.character.activeSkillIds.contains(skill.id)
                                ? Colors.yellow
                                : Colors.transparent,
                        child: Image.asset(
                          'assets/img/skills/${skill.image}',
                          width: 70,
                        ),
                      ),
                      SizedBox(
                          width: 100,
                          child: StyledText(
                            skill.name,
                            textOverflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ))
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(
              height: 40,
            ),

            const StyledText('These are custom skills you have chosen.'),
            StyledIconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ChooseSkill(
                              character: widget.character,
                              skills: userCreatedSkills)));
                },
                icon: Icons.add),

            // custom skills
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 125,
                child: Consumer<CharacterStore>(
                  builder: (context, value, child) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.character.skillIds.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/img/skills/${userCreatedSkills.firstWhere((skill) => skill.id == widget.character.skillIds[index]).image}',
                                  width: 70,
                                ),
                                SizedBox(
                                    width: 70,
                                    child: StyledText(
                                      userCreatedSkills
                                          .firstWhere((skill) =>
                                              skill.id ==
                                              widget.character.skillIds[index])
                                          .name,
                                      textOverflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ))
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
