import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/inventory_item.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class InventoryCard extends StatefulWidget {
  const InventoryCard({super.key, required this.inventoryItem});

  final InventoryItem inventoryItem;

  @override
  State<InventoryCard> createState() => _InventoryCardState();
}

class _InventoryCardState extends State<InventoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const StyledHeading('Item Img'),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledHeading(widget.inventoryItem.name),
                  StyledText(widget.inventoryItem.description),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              StyledText('${widget.inventoryItem.quantity}'),
            ],
          ),
        ));
  }
}
