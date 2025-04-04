import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isPopular;
  final bool isRecommended;
  final DateTime createdAt;

  Food({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isPopular = false,
    this.isRecommended = false,
    required this.createdAt,
  });

  factory Food.fromMap(Map<String, dynamic> map, String id) {
    return Food(
      id: id,
      restaurantId: map['restaurantId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      isPopular: map['isPopular'] ?? false,
      isRecommended: map['isRecommended'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isPopular': isPopular,
      'isRecommended': isRecommended,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}