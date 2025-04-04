import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String foodId;
  final String name;
  final double price;
  final int quantity;

  OrderItem({
    required this.foodId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      foodId: map['foodId'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodId': foodId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}

class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final List<OrderItem> items;
  final String deliveryAddress;
  final String phone;
  final String note;
  final String paymentMethod;
  final String status; // pending, preparing, onTheWay, delivered, cancelled
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.items,
    required this.deliveryAddress,
    required this.phone,
    required this.note,
    required this.paymentMethod,
    required this.status,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order(
      id: id,
      userId: map['userId'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      items: (map['items'] as List<dynamic>)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      deliveryAddress: map['deliveryAddress'] ?? '',
      phone: map['phone'] ?? '',
      note: map['note'] ?? '',
      paymentMethod: map['paymentMethod'] ?? 'cash',
      status: map['status'] ?? 'pending',
      subtotal: (map['subtotal'] as num).toDouble(),
      deliveryFee: (map['deliveryFee'] as num).toDouble(),
      total: (map['total'] as num).toDouble(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'restaurantId': restaurantId,
      'items': items.map((item) => item.toMap()).toList(),
      'deliveryAddress': deliveryAddress,
      'phone': phone,
      'note': note,
      'paymentMethod': paymentMethod,
      'status': status,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Order copyWith({String? status}) {
    return Order(
      id: id,
      userId: userId,
      restaurantId: restaurantId,
      items: items,
      deliveryAddress: deliveryAddress,
      phone: phone,
      note: note,
      paymentMethod: paymentMethod,
      status: status ?? this.status,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      createdAt: createdAt,
    );
  }
}