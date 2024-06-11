import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/inventory_item.dart';
import 'package:flutter_rpg/screens/create_inventory_item_screen/create_inventory_item_screen.dart';
import 'package:flutter_rpg/screens/inventory_screen/inventory_card.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key, required this.character});

  final Character character;

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late final List<InventoryItem> _items;

  @override
  void initState() {
    _items = widget.character.inventory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle('${widget.character.name}\'s Inventory'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Consumer<CharacterStore>(
                builder: (context, value, child) {
                  return ReorderableListView(
                    buildDefaultDragHandles: false,
                    children: [
                      for (int index = 0; index < _items.length; index += 1)
                        ReorderableDragStartListener(
                          index: index,
                          key: Key('$index'),
                          child: InventoryCard(inventoryItem: _items[index]),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      value.reorderInventory(
                          widget.character, oldIndex, newIndex);
                    },
                  );
                },
              ),
            ),
            StyledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => CreateInventoryItem(
                              character: widget.character)));
                },
                child: const StyledText('New Item'))
          ],
        ),
      ),
    );
  }
}
