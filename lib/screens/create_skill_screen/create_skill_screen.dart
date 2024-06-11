import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/services/skill_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_form_textfield.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateSkill extends StatefulWidget {
  const CreateSkill({super.key});

  @override
  State<CreateSkill> createState() => _CreateSkillState();
}

class _CreateSkillState extends State<CreateSkill> {
  final _formGlobalKey = GlobalKey<FormState>();

  String _name = '';
  final String _image = 'backtrack.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Create a skill'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              // form stuff here
              Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // item name
                    StyledFormTextfield(
                      label: 'Skill name',
                      textInputType: TextInputType.text,
                      prefixIcon: const Icon(Icons.title),
                      maxLength: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must enter a value for the name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // submit button
                    StyledButton(
                        onPressed: () {
                          if (_formGlobalKey.currentState!.validate()) {
                            _formGlobalKey.currentState!.save();
                            Provider.of<SkillStore>(context, listen: false)
                                .addSkill(Skill(
                              id: uuid.v4(),
                              name: _name,
                              image: _image,
                            ));

                            _formGlobalKey.currentState!.reset();

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Create Skill',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
