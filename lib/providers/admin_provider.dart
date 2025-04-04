import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/category_model.dart';
import 'package:food_delivery_app/models/promo_code_model.dart';

class AdminProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Category> _categories = [];
  List<PromoCode> _promoCodes = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  List<PromoCode> get promoCodes => _promoCodes;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final snapshot = await _firestore.collection('categories').get();
      _categories = snapshot.docs
          .map((doc) => Category.fromMap(doc.data(), doc.id))
          .toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchPromoCodes() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final snapshot = await _firestore.collection('promoCodes').get();
      _promoCodes = snapshot.docs
          .map((doc) => PromoCode.fromMap(doc.data(), doc.id))
          .toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addCategory(String name, String imageUrl) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _firestore.collection('categories').add({
        'name': name,
        'imageUrl': imageUrl,
        'isActive': true,
        'createdAt': Timestamp.now(),
      });
      
      await fetchCategories();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateCategory(String id, String name, String imageUrl, bool isActive) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _firestore.collection('categories').doc(id).update({
        'name': name,
        'imageUrl': imageUrl,
        'isActive': isActive,
      });
      
      await fetchCategories();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _firestore.collection('categories').doc(id).delete();
      await fetchCategories();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addPromoCode(PromoCode promoCode) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _firestore.collection('promoCodes').add(promoCode.toMap());
      await fetchPromoCodes();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updatePromoCode(PromoCode promoCode) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _firestore.collection('promoCodes').doc(promoCode.id).update(promoCode.toMap());
      await fetchPromoCodes();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deletePromoCode(String id) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      await _firestore.collection('promoCodes').doc(id).delete();
      await fetchPromoCodes();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}