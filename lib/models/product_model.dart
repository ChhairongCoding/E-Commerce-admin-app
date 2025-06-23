import 'package:e_commerce_admin_app/models/category_model.dart';

import 'brand_model.dart';

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
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.brand,
    this.stock,
    this.ratings,
    required this.images,
    this.createdBy,
    this.isActive,
    required this.reviews,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final CategoryModel? categoryId;
  final BrandModel? brand;
  final int? stock;
  final int? ratings;
  final List<Image> images;
  final String? createdBy;
  final bool? isActive;
  final List<dynamic> reviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    CategoryModel? categoryId,
    BrandModel? brand,
    int? stock,
    int? ratings,
    List<Image>? images,
    String? createdBy,
    bool? isActive,
    List<dynamic>? reviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      stock: stock ?? this.stock,
      ratings: ratings ?? this.ratings,
      images: images ?? this.images,
      createdBy: createdBy ?? this.createdBy,
      isActive: isActive ?? this.isActive,
      reviews: reviews ?? this.reviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      categoryId: json["categoryId"] == null
          ? null
          : CategoryModel.fromJson(json["categoryId"]), // ✅ FIXED HERE
      brand: json["brand"] == null ? null : BrandModel.fromJson(json["brand"]),
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
