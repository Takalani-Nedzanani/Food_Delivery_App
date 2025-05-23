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

//   /// Load menu items from Firebase
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

//   /// Handle liking a menu item
//   Future<void> likeItem(MenuItem item) async {
//     try {
//       item.likes += 1;

//       await _database
//           .child('menu')
//           .child(item.id)
//           .update({'likes': item.likes});

//       notifyListeners();
//     } catch (e) {
//       debugPrint("Error liking item: $e");
//     }
//   }

//   /// Place a new order
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

//   /// Get real-time user-specific orders
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

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:food_delivery_app/models/order.dart';
// import 'package:food_delivery_app/models/order_item.dart';

// class AppState with ChangeNotifier {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();

//   List<MenuItem> _menuItems = [];
//   final List<Order> _userOrders = [];
//   final List<OrderItem> _cart = [];

//   List<MenuItem> get menuItems => _menuItems;
//   List<Order> get userOrders => _userOrders;
//   List<OrderItem> get cart => _cart;

//   /// Load menu items from Firebase
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

//   /// Handle liking a menu item
//   Future<void> likeItem(MenuItem item) async {
//     try {
//       item.likes += 1;
//       await _database
//           .child('menu')
//           .child(item.id)
//           .update({'likes': item.likes});
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Error liking item: $e");
//     }
//   }

//   /// Place a new order
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

//   // Get real-time user-specific orders
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

//   /// CART MANAGEMENT

//   void addToCart(MenuItem item, int quantity) {
//     final index = _cart.indexWhere((i) => i.id == item.id);
//     if (index != -1) {
//       _cart[index] = OrderItem(
//         id: item.id,
//         name: item.name,
//         quantity: _cart[index].quantity + quantity,
//         imageUrl: '',
//       );
//     } else {
//       _cart.add(OrderItem(
//         id: item.id,
//         name: item.name,
//         quantity: quantity,
//         imageUrl: '',
//       ));
//     }
//     notifyListeners();
//   }

//   void removeFromCart(String itemId) {
//     _cart.removeWhere((item) => item.id == itemId);
//     notifyListeners();
//   }

//   void clearCart() {
//     _cart.clear();
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_delivery_app/models/menu_item.dart';
import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/models/order_item.dart';
import 'package:food_delivery_app/services/notification_service.dart';

class AppState with ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  List<MenuItem> _menuItems = [];
  final List<Order> _userOrders = [];
  final List<OrderItem> _cart = [];

  final Map<String, String> orderStatusCache =
      {}; // For tracking status changes

  List<MenuItem> get menuItems => _menuItems;
  List<Order> get userOrders => _userOrders;
  List<OrderItem> get cart => _cart;

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

  /// Get real-time user-specific orders with notification on status change
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

      final orders = values.entries.map((entry) {
        return Order.fromMap(entry.key, entry.value as Map<dynamic, dynamic>);
      }).toList();

      _checkAndNotifyStatusChanges(orders);

      return orders;
    });
  }

  /// Internal: Notify user if order status changes
  void _checkAndNotifyStatusChanges(List<Order> orders) {
    for (var order in orders) {
      final previousStatus = orderStatusCache[order.id];
      if (previousStatus != null && previousStatus != order.status) {
        NotificationService.showOrderStatusUpdate(
          'Order #${order.id.substring(0, 6)} Updated',
          'Status changed to ${order.status.toUpperCase()}',
        );
      }
      orderStatusCache[order.id] = order.status;
    }
  }

  /// CART MANAGEMENT

  void addToCart(MenuItem item, int quantity) {
    final index = _cart.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _cart[index] = OrderItem(
        id: item.id,
        name: item.name,
        quantity: _cart[index].quantity + quantity,
        imageUrl: item.imageUrl,
      );
    } else {
      _cart.add(OrderItem(
        id: item.id,
        name: item.name,
        quantity: quantity,
        imageUrl: item.imageUrl,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cart.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
