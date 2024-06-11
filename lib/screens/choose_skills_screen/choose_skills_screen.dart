import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/screens/home_screen/bottom_navigation_bar.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/shared/styled_textfield.dart';
import 'package:provider/provider.dart';

class ChooseSkill extends StatefulWidget {
  const ChooseSkill({super.key, required this.character, required this.skills});

  final Character character;
  final List<Skill> skills;

  @override
  State<ChooseSkill> createState() => _ChooseSkillState();
}

class _ChooseSkillState extends State<ChooseSkill> {
  List<Skill> _foundSkills = [];
  final _searchController = TextEditingController();

  @override
  initState() {
    // at the beginning, all users are shown
    _foundSkills = widget.skills;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Skill> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.skills;
    } else {
      results = widget.skills
          .where((skill) =>
              skill.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundSkills = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Choose Skills'),
        centerTitle: true,
      ),
      bottomNavigationBar: const NavigationBarBottom(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            StyledTextfield(
                onChanged: (value) => _runFilter(value),
                controller: _searchController,
                label: 'Search',
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.search)),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundSkills.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundSkills.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.character
                                    .toggleSkillId(_foundSkills[index].id);
                                Provider.of<CharacterStore>(context,
                                        listen: false)
                                    .updateCharacterSkillsFirebase(
                                        widget.character,
                                        widget.character.skillIds);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: widget.character.skillIds
                                              .contains(_foundSkills[index].id)
                                          ? Colors.yellow
                                          : Colors.transparent,
                                      width: 2)),
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/img/skills/${_foundSkills[index].image}',
                                    width: 70,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StyledText(
                                    _foundSkills[index].name,
                                    textOverflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  )
                                ],
                              ),
                            ),
                          ))
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
