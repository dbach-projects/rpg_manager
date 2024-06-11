import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/create_character_screen/create_character_screen.dart';
import 'package:flutter_rpg/screens/create_skill_screen/create_skill_screen.dart';
import 'package:flutter_rpg/screens/create_vocation_screen/create_vocation_screen.dart';
import 'package:flutter_rpg/screens/home_screen/bottom_navigation_bar.dart';
import 'package:flutter_rpg/screens/home_screen/skill_card.dart';
import 'package:flutter_rpg/screens/home_screen/vocation_card.dart';
import 'package:flutter_rpg/screens/home_screen/character_card.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/skill_store.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/shared/styled_icon_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _sectionHeight = 185;

  @override
  void initState() {
    Provider.of<SkillStore>(context, listen: false).fetchSkillsOnce();
    Provider.of<VocationStore>(context, listen: false).fetchVocationsOnce();
    Provider.of<CharacterStore>(context, listen: false).fetchCharactersOnce();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const StyledTitle('Home'),
          centerTitle: true,
        ),
        bottomNavigationBar: const NavigationBarBottom(),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // CHARACTERS
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const StyledHeading('Characters'),
                        StyledIconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const CreateScreen()));
                            },
                            icon: Icons.add),
                      ]),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: _sectionHeight,
                      child: Consumer<CharacterStore>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.characters.length,
                            itemBuilder: (_, index) {
                              return CharacterCard(value.characters[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  // CLASSES (VOCATIONS)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const StyledHeading('Classes'),
                        StyledIconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const CreateVocation()));
                            },
                            icon: Icons.add),
                      ]),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: _sectionHeight,
                      child: Consumer<VocationStore>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.vocations.length,
                            itemBuilder: (_, index) {
                              return VocationCard(value.vocations[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  // SKILLS
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const StyledHeading('Skills'),
                        StyledIconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const CreateSkill()));
                            },
                            icon: Icons.add),
                      ]),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: _sectionHeight,
                      child: Consumer<SkillStore>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.skills.length,
                            itemBuilder: (_, index) {
                              return SkillCard(value.skills[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
