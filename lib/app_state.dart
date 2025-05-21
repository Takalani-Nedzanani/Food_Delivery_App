// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:food_delivery_app/models/order.dart';

// class AppState with ChangeNotifier {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();

//   List<MenuItem> _menuItems = [];
//   final List<Order> _userOrders = [];

//   List<MenuItem> get menuItems => _menuItems;
//   List<Order> get userOrders => _userOrders;

//   Future<void> loadMenuItems() async {
//     try {
//       DatabaseEvent event = await _database.child('menu').once();
//       DataSnapshot snapshot = event.snapshot;

//       if (snapshot.value != null) {
//         Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
//         _menuItems = values.entries.map((entry) {
//           return MenuItem.fromMap(
//               entry.key, entry.value as Map<dynamic, dynamic>);
//         }).toList();
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint("Error loading menu: $e");
//     }
//   }

//   Future<void> placeOrder(Order order) async {
//     try {
//       DatabaseReference newOrderRef = _database.child('orders').push();
//       await newOrderRef.set({
//         'userId': order.userId,
//         'userName': order.userName,
//         'total': order.total,
//         'status': order.status,
//         'timestamp': order.timestamp.millisecondsSinceEpoch,
//         'notes': order.notes,
//         'items': {
//           for (var item in order.items)
//             item.id: {
//               'id': item.id,
//               'name': item.name,
//               'quantity': item.quantity,
//             }
//         },
//       });
//       debugPrint("Order placed successfully.");
//     } catch (e) {
//       debugPrint("Error placing order: $e");
//       rethrow;
//     }
//   }

//   Stream<List<Order>> getUserOrders(String userId) {
//     return _database
//         .child('orders')
//         .orderByChild('userId')
//         .equalTo(userId)
//         .onValue
//         .map((event) {
//       if (event.snapshot.value == null) return [];

//       Map<dynamic, dynamic> values =
//           event.snapshot.value as Map<dynamic, dynamic>;
//       return values.entries.map((entry) {
//         return Order.fromMap(entry.key, entry.value as Map<dynamic, dynamic>);
//       }).toList();
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_delivery_app/models/menu_item.dart';
import 'package:food_delivery_app/models/order.dart';

class AppState with ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  List<MenuItem> _menuItems = [];
  final List<Order> _userOrders = [];

  List<MenuItem> get menuItems => _menuItems;
  List<Order> get userOrders => _userOrders;

  /// Load menu items from Firebase
  Future<void> loadMenuItems() async {
    try {
      DatabaseEvent event = await _database.child('menu').once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        _menuItems = values.entries.map((entry) {
          return MenuItem.fromMap(
              entry.key, entry.value as Map<dynamic, dynamic>);
        }).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading menu: $e");
    }
  }

  /// Handle liking a menu item
  Future<void> likeItem(MenuItem item) async {
    try {
      item.likes += 1;

      await _database
          .child('menu')
          .child(item.id)
          .update({'likes': item.likes});

      notifyListeners();
    } catch (e) {
      debugPrint("Error liking item: $e");
    }
  }

  /// Place a new order
  Future<void> placeOrder(Order order) async {
    try {
      DatabaseReference newOrderRef = _database.child('orders').push();
      await newOrderRef.set({
        'userId': order.userId,
        'userName': order.userName,
        'total': order.total,
        'status': order.status,
        'timestamp': order.timestamp.millisecondsSinceEpoch,
        'notes': order.notes,
        'items': {
          for (var item in order.items)
            item.id: {
              'id': item.id,
              'name': item.name,
              'quantity': item.quantity,
            }
        },
      });
      debugPrint("Order placed successfully.");
    } catch (e) {
      debugPrint("Error placing order: $e");
      rethrow;
    }
  }

  /// Get real-time user-specific orders
  Stream<List<Order>> getUserOrders(String userId) {
    return _database
        .child('orders')
        .orderByChild('userId')
        .equalTo(userId)
        .onValue
        .map((event) {
      if (event.snapshot.value == null) return [];

      Map<dynamic, dynamic> values =
          event.snapshot.value as Map<dynamic, dynamic>;
      return values.entries.map((entry) {
        return Order.fromMap(entry.key, entry.value as Map<dynamic, dynamic>);
      }).toList();
    });
  }
}
