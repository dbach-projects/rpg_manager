import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/view_character_screen/character_screen.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard(this.character, {super.key});

  final Character character;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => Profile(character: widget.character)));
      },
      child: SizedBox(
        width: 175,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          color: AppColors.secondaryColor,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    'assets/img/vocations/${vocation.image}',
                    width: 90,
                  ),
                ),
                Column(
                  children: [
                    StyledHeading(
                      widget.character.name,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    StyledText(
                      vocation.title,
                      textOverflow: TextOverflow.ellipsis,
                    )
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
