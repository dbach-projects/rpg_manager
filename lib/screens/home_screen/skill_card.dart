import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/screens/view_skill_screen/view_skill_screen.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class SkillCard extends StatelessWidget {
  const SkillCard(this.skill, {super.key});

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => SkillScreen(skill: skill)));
      },
      child: SizedBox(
        width: 175,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: AppColors.secondaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/img/skills/${skill.image}',
                    width: 90,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StyledHeading(
                      skill.name,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
