import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/create_inventory_item_screen/create_inventory_item_screen.dart';
import 'package:flutter_rpg/screens/inventory_screen/inventory_card.dart';
import 'package:flutter_rpg/screens/inventory_screen/inventory_screen.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({super.key, required this.character});

  final Character character;

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          //header
          Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.secondaryColor,
            child: const Row(
              children: [
                Icon(
                  Icons.backpack,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                StyledHeading('Inventory'),
                Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
          // inventory item list
          Container(
            color: AppColors.secondaryColor.withOpacity(.5),
            child: SizedBox(
              height: 200,
              child: Consumer<CharacterStore>(
                builder: (context, value, child) {
                  return ListView.builder(
                    // fix padding at start of list
                    padding: const EdgeInsets.only(),
                    itemCount: widget.character.inventory.length,
                    itemBuilder: (_, index) {
                      return Dismissible(
                        key: ValueKey(
                            value.getInventory(widget.character)[index].id),
                        onDismissed: (direction) {
                          Provider.of<CharacterStore>(context, listen: false)
                              .deleteInventoryItem(widget.character,
                                  value.getInventory(widget.character)[index]);
                        },
                        child: InventoryCard(
                            inventoryItem:
                                value.getInventory(widget.character)[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          //footer
          Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.secondaryColor,
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => InventoryScreen(
                                  character: widget.character)));
                    },
                    child: const Text('More')),
                const Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CreateInventoryItem(
                                  character: widget.character)));
                    },
                    child: const Icon(Icons.add)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
