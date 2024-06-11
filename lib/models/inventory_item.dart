class InventoryItem {
//constructor
  InventoryItem({
    required this.name,
    required this.id,
    required this.quantity,
    this.description = '',
  });

  //fields
  final String name;
  final String id;
  final int quantity;
  final String description;

  // getters
  Map<String, dynamic> get inventoryItemAsMap => {
        "name": name,
        "id": id,
        "quantity": quantity,
        "description": description
      };

  @override
  String toString() {
    return 'id: $id, name: $name, quantity: $quantity, description: $description';
  }
}
