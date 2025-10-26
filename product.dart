class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String sellerId;
  final String sellerName;
  final ProductCondition condition;
  final List<String> imageUrls;
  final int stockQuantity;
  final bool isApproved;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.sellerId,
    required this.sellerName,
    required this.condition,
    required this.imageUrls,
    required this.stockQuantity,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      categoryId: json["category_id"].toString(),
      sellerId: json["seller_id"].toString(),
      sellerName: json["seller_name"] ?? "",
      condition: ProductCondition.values.firstWhere(
        (e) => e.toString().split(".").last == json["condition"],
        orElse: () => ProductCondition.new_,
      ),
      imageUrls: List<String>.from(json["image_urls"] ?? []),
      stockQuantity: json["stock_quantity"] ?? 0,
      isApproved: json["is_approved"] ?? false,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "category_id": categoryId,
      "seller_id": sellerId,
      "seller_name": sellerName,
      "condition": condition.toString().split(".").last,
      "image_urls": imageUrls,
      "stock_quantity": stockQuantity,
      "is_approved": isApproved,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}

enum ProductCondition {
  new_,
  used,
}

extension ProductConditionExtension on ProductCondition {
  String get displayName {
    switch (this) {
      case ProductCondition.new_:
        return "جديد";
      case ProductCondition.used:
        return "مستعمل";
    }
  }
}


