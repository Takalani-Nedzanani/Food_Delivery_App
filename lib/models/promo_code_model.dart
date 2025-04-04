import 'package:cloud_firestore/cloud_firestore.dart';

class PromoCode {
  final String id;
  final String code;
  final String description;
  final String discountType; // 'percentage' or 'fixed'
  final double discountValue;
  final double minOrder;
  final double? maxDiscount;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final int? usageLimit;
  final int usedCount;
  final DateTime createdAt;

  PromoCode({
    required this.id,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minOrder,
    this.maxDiscount,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    this.usageLimit,
    required this.usedCount,
    required this.createdAt,
  });

  factory PromoCode.fromMap(Map<String, dynamic> map, String id) {
    return PromoCode(
      id: id,
      code: map['code'] ?? '',
      description: map['description'] ?? '',
      discountType: map['discountType'] ?? 'percentage',
      discountValue: (map['discountValue'] as num).toDouble(),
      minOrder: (map['minOrder'] as num).toDouble(),
      maxDiscount: map['maxDiscount'] != null ? (map['maxDiscount'] as num).toDouble() : null,
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      isActive: map['isActive'] ?? true,
      usageLimit: map['usageLimit'],
      usedCount: map['usedCount'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,
      'discountType': discountType,
      'discountValue': discountValue,
      'minOrder': minOrder,
      'maxDiscount': maxDiscount,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'isActive': isActive,
      'usageLimit': usageLimit,
      'usedCount': usedCount,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  double calculateDiscount(double orderTotal) {
    if (orderTotal < minOrder) return 0;
    
    double discount = 0;
    if (discountType == 'percentage') {
      discount = orderTotal * discountValue / 100;
      if (maxDiscount != null && discount > maxDiscount!) {
        discount = maxDiscount!;
      }
    } else {
      discount = discountValue;
    }
    
    return discount;
  }
}