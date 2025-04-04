import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;

  Admin({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  factory Admin.fromMap(Map<String, dynamic> map, String id) {
    return Admin(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}