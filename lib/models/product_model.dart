class ProductResponse {
  ProductResponse({required this.success, required this.data});

  final bool? success;
  final Data? data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  @override
  String toString() {
    return "$success, $data, ";
  }

  factory ProductResponse.empty() {
    return ProductResponse(success: null, data: null);
  }
}

class Data {
  Data({required this.products, required this.stats});

  final List<Product> products;
  final Stats? stats;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x)),
            ),
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    );
  }

  @override
  String toString() {
    return "$products, $stats, ";
  }
}

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
    required this.images,
    required this.createdBy,
    required this.isActive,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final Brand? categoryId;
  final Brand? brand;
  final int? stock;
  final int? ratings;
  final List<Image> images;
  final String? createdBy;
  final bool? isActive;
  final List<dynamic> reviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      categoryId: json["categoryId"] == null
          ? null
          : Brand.fromJson(json["categoryId"]),
      brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      stock: json["stock"],
      ratings: json["ratings"],
      images: json["images"] == null
          ? []
          : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      createdBy: json["createdBy"],
      isActive: json["isActive"],
      reviews: json["reviews"] == null
          ? []
          : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $price, $categoryId, $brand, $stock, $ratings, $images, $createdBy, $isActive, $reviews, $createdAt, $updatedAt, $v, ";
  }

  factory Product.empty() {
    return Product(
      id: "",
      name: '',
      description: '',
      price: 0,
      categoryId: null,
      brand: null,
      stock: null,
      ratings: 0,
      images: [],
      createdBy: "",
      isActive: null,
      reviews: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
    );
  }
}

class Brand {
  Brand({required this.id, required this.name});

  final String? id;
  final String? name;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(id: json["_id"], name: json["name"]);
  }

  @override
  String toString() {
    return "$id, $name, ";
  }
}

class Image {
  Image({required this.url, required this.id});

  final String? url;
  final String? id;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(url: json["url"], id: json["_id"]);
  }

  @override
  String toString() {
    return "$url, $id, ";
  }
}

class Stats {
  Stats({
    required this.totalProducts,
    required this.totalStock,
    required this.outOfStock,
    required this.inStock,
    required this.activeProducts,
    required this.inactiveProducts,
  });

  final int? totalProducts;
  final int? totalStock;
  final int? outOfStock;
  final int? inStock;
  final int? activeProducts;
  final int? inactiveProducts;

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalProducts: json["totalProducts"],
      totalStock: json["totalStock"],
      outOfStock: json["outOfStock"],
      inStock: json["inStock"],
      activeProducts: json["activeProducts"],
      inactiveProducts: json["inactiveProducts"],
    );
  }

  @override
  String toString() {
    return "$totalProducts, $totalStock, $outOfStock, $inStock, $activeProducts, $inactiveProducts, ";
  }
}
