class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String? sellerId;
  final bool isAvailable;
  final int stock;
  final List<String> tags;
  final DateTime? createdAt;
  final bool isFeatured;
  final double rating;
  final int reviewCount;
  final String condition; // New property

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.sellerId,
    this.isAvailable = true,
    this.stock = 0,
    this.tags = const [],
    this.createdAt,
    this.isFeatured = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.condition = 'new', // Default value
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"].toDouble(),
      imageUrl: json["image_url"],
      categoryId: json["category_id"],
      sellerId: json["seller_id"],
      isAvailable: json["is_available"] ?? true,
      stock: json["stock"] ?? 0,
      tags: List<String>.from(json["tags"] ?? []),
      createdAt: json["created_at"] != null 
          ? DateTime.parse(json["created_at"]) 
          : null,
      isFeatured: json["is_featured"] ?? false,
      rating: (json["rating"] ?? 0.0).toDouble(),
      reviewCount: json["review_count"] ?? 0,
      condition: json["condition"] ?? 'new',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "image_url": imageUrl,
      "category_id": categoryId,
      "seller_id": sellerId,
      "is_available": isAvailable,
      "stock": stock,
      "tags": tags,
      "created_at": createdAt?.toIso8601String(),
      "is_featured": isFeatured,
      "rating": rating,
      "review_count": reviewCount,
      "condition": condition,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? categoryId,
    String? sellerId,
    bool? isAvailable,
    int? stock,
    List<String>? tags,
    DateTime? createdAt,
    bool? isFeatured,
    double? rating,
    int? reviewCount,
    String? condition,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      sellerId: sellerId ?? this.sellerId,
      isAvailable: isAvailable ?? this.isAvailable,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      isFeatured: isFeatured ?? this.isFeatured,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      condition: condition ?? this.condition,
    );
  }

  String get formattedPrice => '${price.toStringAsFixed(0)} ل.س';
  bool get isInStock => stock > 0;
  bool get hasRating => rating > 0;
  int get stockQuantity => stock; // Added for clarity, can be removed if 'stock' is used directly
}

