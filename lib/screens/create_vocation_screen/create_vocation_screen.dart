import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_form_textfield.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateVocation extends StatefulWidget {
  const CreateVocation({super.key});

  @override
  State<CreateVocation> createState() => _CreateVocationState();
}

class _CreateVocationState extends State<CreateVocation> {
  final _formGlobalKey = GlobalKey<FormState>();

  String _name = '';
  String _title = '';
  String _description = '';
  String _weapon = '';
  String _ability = '';
  final String _image = 'terminal_raider.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Create a class'),
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
                      label: 'Class name',
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

                    // class title
                    StyledFormTextfield(
                      label: 'Class title',
                      textInputType: TextInputType.text,
                      prefixIcon: const Icon(Icons.title),
                      maxLength: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a class title.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value!;
                      },
                    ),

                    // class description
                    StyledFormTextfield(
                      label: 'Class description',
                      textInputType: TextInputType.multiline,
                      maxLines: 4,
                      prefixIcon: const Icon(Icons.comment),
                      maxLength: 120,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'Enter a description at least 5 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),

                    // class weapon
                    StyledFormTextfield(
                      label: 'Class weapon',
                      textInputType: TextInputType.text,
                      prefixIcon: const Icon(Icons.comment),
                      maxLength: 20,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'Enter a weapon name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _weapon = value!;
                      },
                    ),

                    // class ability
                    StyledFormTextfield(
                      label: 'Class ability',
                      textInputType: TextInputType.text,
                      prefixIcon: const Icon(Icons.comment),
                      maxLength: 20,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'Enter an ability name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _ability = value!;
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
                            Provider.of<VocationStore>(context, listen: false)
                                .addVocation(Vocation(
                              id: uuid.v4(),
                              name: _name,
                              title: _title,
                              description: _description,
                              weapon: _weapon,
                              ability: _ability,
                              image: _image,
                            ));

                            _formGlobalKey.currentState!.reset();

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Create Class',
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
