class CategoryResponse {
  CategoryResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool? success;
  final int? count;
  final List<CategoryModel> data;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null
          ? []
          : List<CategoryModel>.from(json["data"]!.map((x) => CategoryModel.fromJson(x))),
    );
  }

  @override
  String toString() {
    return "$success, $count, $data, ";
  }

  factory CategoryResponse.empty() {
    return CategoryResponse(data: [], success: null, count: null);
  }
}
class CategoryModel {
  final String? id;
  final String? name;
  final String? description;
  // This can be typed to another CategoryModel? if it's self-referential
  final dynamic parentCategory;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalProducts;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.parentCategory,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.totalProducts,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      parentCategory: json['parentCategory'], // Stays dynamic to accept null or object
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.tryParse(json['updatedAt'] as String),
      totalProducts: json['totalProducts'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'parentCategory': parentCategory,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'totalProducts': totalProducts,
    };
  }
}