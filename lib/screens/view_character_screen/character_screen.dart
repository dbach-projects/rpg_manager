import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/view_character_screen/current_stats.dart';
import 'package:flutter_rpg/screens/view_character_screen/heart.dart';
import 'package:flutter_rpg/screens/view_character_screen/inventory_list.dart';
import 'package:flutter_rpg/screens/view_character_screen/skill_list.dart';
import 'package:flutter_rpg/screens/view_character_screen/stats_table.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.character});

  final Character character;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final Vocation vocation;

  @override
  void initState() {
    vocation = Provider.of<VocationStore>(context, listen: false)
        .vocations
        .firstWhere((element) => widget.character.vocationId == element.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        // First sliver
        SliverAppBar(
          pinned: true,
          expandedHeight: 165.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            // clear default title padding so centering works
            titlePadding: const EdgeInsets.only(),
            title: StyledTitle(widget.character.name),
            background: SizedBox(
              width: double.infinity,
              child: Opacity(
                opacity: 0.65,
                child: Image.asset('assets/img/vocations/${vocation.image}',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),

        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const StyledHeading('Class'),
                            StyledText(vocation.title)
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const StyledHeading('Description'),
                            StyledText(vocation.description)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: Heart(character: widget.character)),
                ]),

                // current health
                CurrentHealth(character: widget.character),

                // weapon, ability and slogan
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: Icon(Icons.code, color: AppColors.primaryColor),
                ),

                // inventory preview

                InventoryList(character: widget.character),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: AppColors.secondaryColor.withOpacity(.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StyledHeading('Slogan'),
                        StyledText(widget.character.slogan),
                        const SizedBox(
                          height: 10,
                        ),
                        const StyledHeading('Weapon of choice'),
                        StyledText(vocation.weapon),
                        const SizedBox(
                          height: 10,
                        ),
                        const StyledHeading('Unique Ability'),
                        StyledText(vocation.ability),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                // stats and skills
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      StatsTable(widget.character),
                      SkillList(widget.character),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // save button
                StyledButton(
                    onPressed: () {
                      Provider.of<CharacterStore>(context, listen: false)
                          .saveCharacter(widget.character);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const StyledHeading('Character was saved.'),
                        showCloseIcon: true,
                        duration: const Duration(seconds: 2),
                        backgroundColor: AppColors.secondaryColor,
                      ));
                    },
                    child: const StyledHeading('Save Character')),
                const SizedBox(
                  height: 20,
                ),
                // delete button
                StyledButton(
                    onPressed: () {
                      Provider.of<CharacterStore>(context, listen: false)
                          .removeCharacter(widget.character);

                      Navigator.pop(context);
                    },
                    child: const StyledHeading('Delete Character')),
              ],
            );
          },
          childCount: 1,
        )),
      ]),
    );
  }
}
