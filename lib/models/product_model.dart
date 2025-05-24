class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.brand,
    required this.stock,
    required this.ratings,
    required this.reviews,
    required this.images,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final String? categoryId;
  final String? brand;
  final int? stock;
  final double? ratings;
  final List<dynamic> reviews;
  final List<Image> images;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      categoryId: json["categoryId"],
      brand: json["brand"],
      stock: json["stock"],
      ratings: json["ratings"],
      reviews: json["reviews"] == null
          ? []
          : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      images: json["images"] == null
          ? []
          : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      createdBy: json["createdBy"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $price, $categoryId, $brand, $stock, $ratings, $reviews, $images, $createdBy, $createdAt, $updatedAt, ";
  }
}

class Image {
  Image({required this.url});

  final String? url;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(url: json["url"]);
  }

  @override
  String toString() {
    return "$url, ";
  }
}
