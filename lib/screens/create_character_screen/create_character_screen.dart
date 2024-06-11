import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create_character_screen/create_vocation_card.dart';
import 'package:flutter_rpg/screens/home_screen/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/shared/styled_textfield.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // handling vocation selection
  Vocation selectedVocation =
      vocationsPredefined.firstWhere((element) => element.name == 'junkie');

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeading('Missing character name'),
              content: const StyledText(
                  'Every good rpg character needs a great name.'),
              actions: [
                StyledButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const StyledHeading('close'))
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });

      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeading('Missing slogan'),
              content: const StyledText('Remember to add a catchy slogan...'),
              actions: [
                StyledButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const StyledHeading('close'))
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });

      return;
    }

    //create new character
    Provider.of<CharacterStore>(context, listen: false).addCharacter(Character(
      vocationId: selectedVocation.id,
      name: _nameController.text.trim(),
      slogan: _sloganController.text.trim(),
      id: uuid.v4(),
    ));

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // welcome message
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Welcome, New Player'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character'),
              ),
              const SizedBox(
                height: 30,
              ),

              // input for name and slogan
              StyledTextfield(
                  controller: _nameController,
                  label: 'Character name',
                  textInputType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person_2)),
              const SizedBox(
                height: 20,
              ),
              StyledTextfield(
                  controller: _sloganController,
                  label: 'Character slogan',
                  textInputType: TextInputType.text,
                  prefixIcon: const Icon(Icons.chat)),
              const SizedBox(
                height: 30,
              ),

              // select vocation title
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Choose a vocation.'),
              ),
              const Center(
                child: StyledText('This determines your available skills.'),
              ),
              const SizedBox(
                height: 30,
              ),

              // vocation cards
              SizedBox(
                height: 200,
                child: Consumer<VocationStore>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.vocations.length,
                      itemBuilder: (_, index) {
                        return Dismissible(
                          key: ValueKey(value.vocations[index].id),
                          onDismissed: (direction) {
                            Provider.of<VocationStore>(context, listen: false)
                                .removeVocation(value.vocations[index]);
                          },
                          child: CreateVocationCard(
                            vocation: value.vocations[index],
                            onTap: updateVocation,
                            selected: selectedVocation.id ==
                                value.vocations[index].id,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // good luck message
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeading('Good Luck'),
              ),
              const Center(
                child: StyledText('And enjoy the journey...'),
              ),
              const SizedBox(
                height: 30,
              ),

              Center(
                child: StyledButton(
                    onPressed: handleSubmit,
                    child: const StyledHeading('Create Character')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
