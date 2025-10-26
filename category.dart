class ProductCategory {
  final String id;
  final String name;
  final String description;
  final String? iconUrl;

  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      iconUrl: json["icon_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "icon_url": iconUrl,
    };
  }
}

// فئات افتراضية للتطبيق
class DefaultCategories {
  static List<ProductCategory> get categories => [
    ProductCategory(
      id: "1",
      name: "ملابس",
      description: "ملابس رجالية ونسائية وأطفال",
      iconUrl: "assets/icons/clothes.png",
    ),
    ProductCategory(
      id: "2",
      name: "أجهزة",
      description: "أجهزة كهربائية ومنزلية",
      iconUrl: "assets/icons/appliances.png",
    ),
    ProductCategory(
      id: "3",
      name: "إلكترونيات",
      description: "هواتف، حاسوب، وأجهزة إلكترونية",
      iconUrl: "assets/icons/electronics.png",
    ),
    ProductCategory(
      id: "4",
      name: "أدوات منزلية",
      description: "أثاث وأدوات المطبخ والمنزل",
      iconUrl: "assets/icons/home.png",
    ),
    ProductCategory(
      id: "5",
      name: "مستعمل",
      description: "منتجات مستعملة بحالة جيدة",
      iconUrl: "assets/icons/used.png",
    ),
  ];
}


