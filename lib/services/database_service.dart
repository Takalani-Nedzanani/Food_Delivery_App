import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<UserModel> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      throw Exception('User not found');
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> updateUserProfile({
    required String userId,
    required String name,
    required String phone,
    String? address,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': name,
        'phone': phone,
        if (address != null) 'address': address,
      });
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> createOrder(Order order) async {
    try {
      await _firestore.collection('orders').doc(order.id).set(order.toMap());
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }
}

//new lines added if not working delete them.
extension on Order {
  String? get id => null;

  Map<String, dynamic> toMap() {
    throw UnimplementedError('toMap() has not been implemented.');
  }
}
