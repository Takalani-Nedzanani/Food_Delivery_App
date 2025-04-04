import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int deliveryTime;
  final double deliveryFee;
  final double minOrder;
  final String address;
  final bool isOpen;
  final DateTime createdAt;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.rating = 0,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minOrder,
    required this.address,
    required this.isOpen,
    required this.createdAt,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map, String id) {
    return Restaurant(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] as num).toDouble(),
      deliveryTime: map['deliveryTime'] ?? 30,
      deliveryFee: (map['deliveryFee'] as num).toDouble(),
      minOrder: (map['minOrder'] as num).toDouble(),
      address: map['address'] ?? '',
      isOpen: map['isOpen'] ?? true,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'minOrder': minOrder,
      'address': address,
      'isOpen': isOpen,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}