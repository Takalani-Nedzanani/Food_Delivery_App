import 'package:food_delivery_app/models/order_item.dart';

class Order {
  final String id;
  final String userId;
  final String userName;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime timestamp;
  final String? notes;
  
  Order({
    required this.id,
    required this.userId,
    required this.userName,
    required this.items,
    required this.total,
    required this.status,
    required this.timestamp,
    this.notes,
  });

  factory Order.fromMap(String id, Map<dynamic, dynamic> map) {
    List<OrderItem> items = [];
    if (map['items'] != null) {
      final itemsMap = map['items'] as Map<dynamic, dynamic>;
      items = itemsMap.entries.map((entry) {
        return OrderItem.fromMap(entry.key, entry.value as Map<dynamic, dynamic>);
      }).toList();
    }
    
    return Order(
      id: id,
      userId: map['userId']?.toString() ?? '',
      userName: map['userName']?.toString() ?? '',
      items: items,
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      status: map['status']?.toString() ?? 'pending',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int? ?? 0),
      notes: map['notes']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'items': {for (var item in items) item.id: item.toMap()},
      'total': total,
      'status': status,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'notes': notes,
    };
  }

  static Order empty() {
    return Order(
      id: '',
      userId: '',
      userName: '',
      items: [],
      total: 0.0,
      status: 'pending',
      timestamp: DateTime.now(),
      notes: null,
    );
  }

  bool get isPending => status == 'pending';
  bool get isPreparing => status == 'preparing';
  bool get isReady => status == 'ready';
  bool get isCollected => status == 'collected';

  int get statusColor {
    switch (status) {
      case 'pending':
        return 0xFFFFA500; // Orange
      case 'preparing':
        return 0xFF0000FF; // Blue
      case 'ready':
        return 0xFF008000; // Green
      case 'collected':
        return 0xFF808080; // Gray
      default:
        return 0xFF000000; // Black
    }
  }
}