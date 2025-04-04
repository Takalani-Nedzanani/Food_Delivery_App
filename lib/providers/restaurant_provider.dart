import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/models/food_model.dart';

/// Provider class that manages all restaurant and food-related operations
class RestaurantProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<Restaurant> _restaurants = [];
  List<Food> _popularFoods = [];
  List<Food> _recommendedFoods = [];
  bool _isLoading = false;

  List<Restaurant> get restaurants => _restaurants;
  List<Food> get popularFoods => _popularFoods;
  List<Food> get recommendedFoods => _recommendedFoods;
  bool get isLoading => _isLoading;

  /// Fetches all restaurants
  Future<void> fetchRestaurants() async {
    try {
      _setLoading(true);
      
      final snapshot = await _firestore
          .collection('restaurants')
          .where('isActive', isEqualTo: true)
          .orderBy('name')
          .get();

      _restaurants = snapshot.docs
          .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
          .toList();

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to fetch restaurants: ${e.toString()}');
    }
  }

  /// Fetches popular food items
  Future<void> fetchPopularFoods() async {
    try {
      _setLoading(true);
      
      final snapshot = await _firestore
          .collection('foods')
          .where('isPopular', isEqualTo: true)
          .limit(10)
          .get();

      _popularFoods = snapshot.docs
          .map((doc) => Food.fromMap(doc.data(), doc.id))
          .toList();

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to fetch popular foods: ${e.toString()}');
    }
  }

  /// Fetches recommended food items
  Future<void> fetchRecommendedFoods() async {
    try {
      _setLoading(true);
      
      final snapshot = await _firestore
          .collection('foods')
          .where('isRecommended', isEqualTo: true)
          .limit(10)
          .get();

      _recommendedFoods = snapshot.docs
          .map((doc) => Food.fromMap(doc.data(), doc.id))
          .toList();

      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to fetch recommended foods: ${e.toString()}');
    }
  }

  /// Gets a single restaurant by ID
  Future<Restaurant> getRestaurantById(String id) async {
    try {
      _setLoading(true);
      
      final doc = await _firestore.collection('restaurants').doc(id).get();
      if (!doc.exists) {
        throw Exception('Restaurant not found');
      }

      _setLoading(false);
      return Restaurant.fromMap(doc.data()!, doc.id);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to get restaurant: ${e.toString()}');
    }
  }

  /// Gets all food items for a specific restaurant
  Future<List<Food>> getFoodsByRestaurant(String restaurantId) async {
    try {
      _setLoading(true);
      
      final snapshot = await _firestore
          .collection('foods')
          .where('restaurantId', isEqualTo: restaurantId)
          .orderBy('name')
          .get();

      _setLoading(false);
      return snapshot.docs
          .map((doc) => Food.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to get restaurant foods: ${e.toString()}');
    }
  }

  /// Gets a single food item by ID
  Future<Food> getFoodById(String id) async {
    try {
      _setLoading(true);
      
      final doc = await _firestore.collection('foods').doc(id).get();
      if (!doc.exists) {
        throw Exception('Food item not found');
      }

      _setLoading(false);
      return Food.fromMap(doc.data()!, doc.id);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to get food item: ${e.toString()}');
    }
  }

  /// Adds a new restaurant (admin only)
  Future<void> addRestaurant(Restaurant restaurant) async {
    try {
      _setLoading(true);
      await _firestore.collection('restaurants').add(restaurant.toMap());
      await fetchRestaurants(); // Refresh list
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to add restaurant: ${e.toString()}');
    }
  }

  /// Updates an existing restaurant (admin only)
  Future<void> updateRestaurant(Restaurant restaurant) async {
    try {
      _setLoading(true);
      await _firestore.collection('restaurants')
          .doc(restaurant.id)
          .update(restaurant.toMap());
      await fetchRestaurants(); // Refresh list
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to update restaurant: ${e.toString()}');
    }
  }

  /// Adds a new food item (admin only)
  Future<void> addFood(Food food) async {
    try {
      _setLoading(true);
      await _firestore.collection('foods').add(food.toMap());
      // Refresh relevant lists
      await Future.wait([
        fetchPopularFoods(),
        fetchRecommendedFoods(),
      ]);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      throw Exception('Failed to add food item: ${e.toString()}');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}