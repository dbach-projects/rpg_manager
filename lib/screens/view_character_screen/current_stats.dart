import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class CurrentHealth extends StatefulWidget {
  const CurrentHealth({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  State<CurrentHealth> createState() => _CurrentHealthState();
}

class _CurrentHealthState extends State<CurrentHealth> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.secondaryColor.withOpacity(.5),
          child: Column(
            children: [
              // health
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.character.decreaseCurrentHealth();
                        });
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      )),
                  Column(
                    children: [
                      const StyledHeading('Health'),
                      StyledText('${widget.character.currentHealth}'),
                    ],
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.primaryColor),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.character.increaseCurrentHealth();
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(height: 20),

              // mana
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.character.decreaseCurrentMana();
                        });
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      )),
                  Column(
                    children: [
                      const StyledHeading('Mana'),
                      StyledText('${widget.character.currentMana}'),
                    ],
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.character.increaseCurrentMana();
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
