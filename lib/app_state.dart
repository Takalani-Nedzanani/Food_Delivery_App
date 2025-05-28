// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:food_delivery_app/models/order.dart';
// import 'package:food_delivery_app/models/order_item.dart';
// import 'package:food_delivery_app/services/notification_service.dart';

// class AppState with ChangeNotifier {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();

//   List<MenuItem> _menuItems = [];
//   final List<Order> _userOrders = [];
//   final List<OrderItem> _cart = [];

//   final Map<String, String> orderStatusCache = {};
//   List<MenuItem> get menuItems => _menuItems;
//   List<Order> get userOrders => _userOrders;

//   String? currentUserId;
//   final Set<String> _likedItemIds = {}; // Locally liked item IDs

//   void setUserId(String userId) {
//     currentUserId = userId;
//     loadUserLikes(); // Load likes for the user
//   }

//   Future<void> loadMenuItems() async {
//     try {
//       DatabaseEvent event = await _database.child('menu').once();
//       DataSnapshot snapshot = event.snapshot;

//       if (snapshot.value != null) {
//         Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

//         _menuItems = values.entries.map((entry) {
//           final itemData = entry.value as Map<dynamic, dynamic>;

//           String imageUrl = '';
//           if (itemData['imageUrl'] != null) {
//             imageUrl = itemData['imageUrl'].toString();
//             if (imageUrl.startsWith('menu_items/')) {
//               imageUrl =
//                   'https://firebasestorage.googleapis.com/v0/b/cut-smartbanking-app.appspot.com/o/${Uri.encodeComponent(imageUrl)}?alt=media';
//             }
//           }

//           return MenuItem(
//             id: entry.key.toString(),
//             name: itemData['name']?.toString() ?? 'No Name',
//             description: itemData['description']?.toString() ?? '',
//             price: (itemData['price'] as num?)?.toDouble() ?? 0.0,
//             category: itemData['category']?.toString() ?? 'Uncategorized',
//             imageUrl: imageUrl,
//             likes: (itemData['likes'] as int?) ?? 0,
//           );
//         }).toList();

//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint("Error loading menu: $e");
//     }
//   }

//   Future<void> loadUserLikes() async {
//     if (currentUserId == null) return;

//     try {
//       DatabaseEvent event =
//           await _database.child('likes').child(currentUserId!).once();
//       final snapshot = event.snapshot;

//       _likedItemIds.clear();

//       if (snapshot.value != null) {
//         final Map<dynamic, dynamic> values =
//             snapshot.value as Map<dynamic, dynamic>;
//         _likedItemIds.addAll(values.keys.cast<String>());
//       }

//       notifyListeners();
//     } catch (e) {
//       debugPrint("Error loading user likes: $e");
//     }
//   }

//   bool isLiked(String itemId) => _likedItemIds.contains(itemId);

//   Future<void> likeItem(MenuItem item) async {
//     if (currentUserId == null || _likedItemIds.contains(item.id)) return;

//     try {
//       // Add like in user node
//       await _database
//           .child('likes')
//           .child(currentUserId!)
//           .child(item.id)
//           .set(true);

//       // Increment global likes count
//       final newLikeCount = item.likes + 1;
//       await _database
//           .child('menu')
//           .child(item.id)
//           .update({'likes': newLikeCount});

//       item.likes = newLikeCount;
//       _likedItemIds.add(item.id);
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Error liking item: $e");
//     }
//   }

//   Future<void> unlikeItem(MenuItem item) async {
//     if (currentUserId == null || !_likedItemIds.contains(item.id)) return;

//     try {
//       // Remove like from user node
//       await _database
//           .child('likes')
//           .child(currentUserId!)
//           .child(item.id)
//           .remove();

//       // Decrement global likes count
//       final newLikeCount = (item.likes > 0) ? item.likes - 1 : 0;
//       await _database
//           .child('menu')
//           .child(item.id)
//           .update({'likes': newLikeCount});

//       item.likes = newLikeCount;
//       _likedItemIds.remove(item.id);
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Error unliking item: $e");
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
//       final orders = values.entries.map((entry) {
//         return Order.fromMap(entry.key, entry.value as Map<dynamic, dynamic>);
//       }).toList();

//       _checkAndNotifyStatusChanges(orders);
//       return orders;
//     });
//   }

//   void _checkAndNotifyStatusChanges(List<Order> orders) {
//     for (var order in orders) {
//       final previousStatus = orderStatusCache[order.id];
//       if (previousStatus != null && previousStatus != order.status) {
//         NotificationService.showOrderStatusUpdate(
//           'Order #${order.id.substring(0, 6)} Updated',
//           'Status changed to ${order.status.toUpperCase()}',
//         );
//       }
//       orderStatusCache[order.id] = order.status;
//     }
//   }

//   void addToCart(MenuItem item, int quantity) {
//     final index = _cart.indexWhere((i) => i.id == item.id);
//     if (index != -1) {
//       _cart[index] = OrderItem(
//         id: item.id,
//         name: item.name,
//         quantity: _cart[index].quantity + quantity,
//         imageUrl: item.imageUrl,
//       );
//     } else {
//       _cart.add(OrderItem(
//         id: item.id,
//         name: item.name,
//         quantity: quantity,
//         imageUrl: item.imageUrl,
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

  final Map<String, String> orderStatusCache = {};
  List<MenuItem> get menuItems => _menuItems;
  List<Order> get userOrders => _userOrders;

  String? currentUserId;
  final Set<String> _likedItemIds = {};

  void setUserId(String userId) {
    currentUserId = userId;
    loadUserLikes();
  }

  Future<void> loadMenuItems() async {
    try {
      DatabaseEvent event = await _database.child('menu').once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

        _menuItems = values.entries.map((entry) {
          final itemData = entry.value as Map<dynamic, dynamic>;

          String imageUrl = '';
          if (itemData['imageUrl'] != null) {
            imageUrl = itemData['imageUrl'].toString();
            if (imageUrl.startsWith('menu_items/')) {
              imageUrl =
                  'https://firebasestorage.googleapis.com/v0/b/cut-smartbanking-app.appspot.com/o/${Uri.encodeComponent(imageUrl)}?alt=media';
            }
          }

          return MenuItem(
            id: entry.key.toString(),
            name: itemData['name']?.toString() ?? 'No Name',
            description: itemData['description']?.toString() ?? '',
            price: (itemData['price'] as num?)?.toDouble() ?? 0.0,
            category: itemData['category']?.toString() ?? 'Uncategorized',
            imageUrl: imageUrl,
            likes: (itemData['likes'] as int?) ?? 0,
          );
        }).toList();

        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading menu: $e");
    }
  }

  Future<void> loadUserLikes() async {
    if (currentUserId == null) return;

    try {
      DatabaseEvent event =
          await _database.child('likes').child(currentUserId!).once();
      final snapshot = event.snapshot;

      _likedItemIds.clear();

      if (snapshot.value != null) {
        final Map<dynamic, dynamic> values =
            snapshot.value as Map<dynamic, dynamic>;
        _likedItemIds.addAll(values.keys.cast<String>());
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading user likes: $e");
    }
  }

  bool isLiked(String itemId) => _likedItemIds.contains(itemId);

  Future<void> likeItem(MenuItem item) async {
    if (currentUserId == null || _likedItemIds.contains(item.id)) return;

    try {
      await _database
          .child('likes')
          .child(currentUserId!)
          .child(item.id)
          .set(true);

      final newLikeCount = item.likes + 1;
      await _database
          .child('menu')
          .child(item.id)
          .update({'likes': newLikeCount});

      item.likes = newLikeCount;
      _likedItemIds.add(item.id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error liking item: $e");
    }
  }

  Future<void> unlikeItem(MenuItem item) async {
    if (currentUserId == null || !_likedItemIds.contains(item.id)) return;

    try {
      await _database
          .child('likes')
          .child(currentUserId!)
          .child(item.id)
          .remove();

      final newLikeCount = (item.likes > 0) ? item.likes - 1 : 0;
      await _database
          .child('menu')
          .child(item.id)
          .update({'likes': newLikeCount});

      item.likes = newLikeCount;
      _likedItemIds.remove(item.id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error unliking item: $e");
    }
  }

  /// 🔶 UPDATED: Accepts `paymentMethod` and saves it to the database
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
        'paymentMethod': order.paymentMethod, // Save payment method
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
