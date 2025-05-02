import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppState with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<MenuItem> _menuItems = [];
  List<Order> _userOrders = [];

  List<MenuItem> get menuItems => _menuItems; 
  List<Order> get userOrders => _userOrders;

  Future<void> loadMenuItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('menu').get();
      _menuItems = snapshot.docs.map((doc) {
        return MenuItem.fromFirestore(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error loading menu: $e");
    }
  }

  Future<void> placeOrder(Order order) async {
    try {
      await _firestore.collection('orders').add(order.toFirestore());
    } catch (e) {
      print("Error placing order: $e");
      rethrow;
    }
  }

  Stream<List<Order>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Order.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory MenuItem.fromFirestore(String id, Map<String, dynamic> data) {
    return MenuItem(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num).toDouble(),
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}

class Order {
  final String id;
  final String userId;
  final String userName;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime timestamp;
  final String? notes;

  Order({
    required this.id,
    required this.userId,
    required this.userName,
    required this.items,
    required this.total,
    required this.status,
    required this.timestamp,
    this.notes,
  });

  factory Order.fromFirestore(String id, Map<String, dynamic> data) {
    List<OrderItem> items = [];
    if (data['items'] != null) {
      final itemsMap = data['items'] as Map<String, dynamic>;
      items = itemsMap.entries.map((entry) {
        return OrderItem.fromFirestore(
            entry.key, entry.value as Map<String, dynamic>);
      }).toList();
    }

    return Order(
      id: id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      items: items,
      total: (data['total'] as num).toDouble(),
      status: data['status'] ?? 'pending',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'userName': userName,
      'items': {for (var item in items) item.id: item.toFirestore()},
      'total': total,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
      'notes': notes,
    };
  }
}

class OrderItem {
  final String id;
  final String name;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory OrderItem.fromFirestore(String id, Map<String, dynamic> data) {
    return OrderItem(
      id: id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
