class OrderItem {
  final String id;
  final String name;
  final int quantity;
  final String imageUrl; // Add image URL

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderItem.fromMap(String id, Map<dynamic, dynamic> map) {
    return OrderItem(
      id: id,
      name: map['name']?.toString() ?? '',
      quantity: map['quantity'] is int
          ? map['quantity']
          : int.tryParse(map['quantity']?.toString() ?? '1') ?? 1,
      imageUrl: map['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  static OrderItem empty() {
    return OrderItem(
      id: '',
      name: '',
      quantity: 1,
      imageUrl: '',
    );
  }
}
