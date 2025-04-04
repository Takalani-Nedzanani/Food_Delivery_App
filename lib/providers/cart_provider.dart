import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/food_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  double _deliveryFee = 5.0;

  List<CartItem> get cartItems => _cartItems;
  double get deliveryFee => _deliveryFee;
  double get subtotal => _cartItems.fold(
        0,
        (sum, item) => sum + (item.food.price * item.quantity),
      );
  double get total => subtotal + _deliveryFee;

  void addToCart(Food food, {int quantity = 1}) {
    final index = _cartItems.indexWhere((item) => item.food.id == food.id);
    
    if (index >= 0) {
      _cartItems[index].quantity += quantity;
    } else {
      _cartItems.add(CartItem(food: food, quantity: quantity));
    }
    
    notifyListeners();
  }

  void removeFromCart(String foodId) {
    _cartItems.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  void updateQuantity(String foodId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.food.id == foodId);
    
    if (index >= 0) {
      _cartItems[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}