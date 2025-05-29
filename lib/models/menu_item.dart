class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  int likes;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.likes = 0,
  });

  factory MenuItem.fromMap(String id, Map<dynamic, dynamic> map) {
    return MenuItem(
      id: id,
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      category: map['category']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      likes: map['likes'] is int ? map['likes'] : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'likes': likes,
    };
  }

  static MenuItem empty() {
    return MenuItem(
      id: '',
      name: '',
      description: '',
      price: 0.0,
      category: '',
      imageUrl: '',
      likes: 0,
    );
  }
}

