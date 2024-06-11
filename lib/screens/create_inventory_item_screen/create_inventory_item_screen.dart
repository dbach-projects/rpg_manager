import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/models/inventory_item.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_form_textfield.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateInventoryItem extends StatefulWidget {
  const CreateInventoryItem({super.key, required this.character});

  final Character character;

  @override
  State<CreateInventoryItem> createState() => _CreateInventoryItemState();
}

class _CreateInventoryItemState extends State<CreateInventoryItem> {
  final _formGlobalKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Add Item to Inventory'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            const Expanded(
                child: SizedBox(
              height: 20,
            )),

            // form stuff here
            Form(
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // item name
                  StyledFormTextfield(
                    label: 'Item name',
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.title),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must enter a value for the title.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),

                  // item description
                  StyledFormTextfield(
                    label: 'Item description',
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.comment),
                    maxLength: 40,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 5) {
                        return 'Enter a description at least 5 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),

                  // item quantity
                  StyledFormTextfield(
                    label: 'Item quantity',
                    initialValue: '1',
                    textInputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.numbers),
                    maxLength: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a quantity.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _quantity = int.parse(value!);
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
                          Provider.of<CharacterStore>(context, listen: false)
                              .createInventoryItem(
                                  widget.character,
                                  InventoryItem(
                                      name: _name,
                                      id: uuid.v4(),
                                      quantity: _quantity,
                                      description: _description));

                          _formGlobalKey.currentState!.reset();

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Add Item',
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
    );
  }
}
