class OrderItem {
  final String id;
  final String name;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory OrderItem.fromMap(String id, Map<dynamic, dynamic> map) {
    return OrderItem(
      id: id,
      name: map['name']?.toString() ?? '',
      quantity: map['quantity'] is int
          ? map['quantity']
          : int.tryParse(map['quantity']?.toString() ?? '1') ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id here for consistency
      'name': name,
      'quantity': quantity,
    };
  }

  static OrderItem empty() {
    return OrderItem(
      id: '',
      name: '',
      quantity: 1,
    );
  }
}





// class OrderItem {
//   final String id;
//   final String name;
//   final int quantity;
  
//   OrderItem({
//     required this.id,
//     required this.name,
//     required this.quantity,
//   });

//   factory OrderItem.fromMap(String id, Map<dynamic, dynamic> map) {
//     return OrderItem(
//       id: id,
//       name: map['name']?.toString() ?? '',
//       quantity: (map['quantity'] as int?) ?? 1,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'quantity': quantity,
//     };
//   }

//   static OrderItem empty() {
//     return OrderItem(
//       id: '',
//       name: '',
//       quantity: 1,
//     );
//   }
// }