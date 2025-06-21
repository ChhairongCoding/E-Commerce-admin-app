class CategoryResponse {
  CategoryResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool? success;
  final int? count;
  final List<Category> data;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null
          ? []
          : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
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

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.parenCategory,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.productCount,
  });

  final String? id;
  final String? name;
  final String? description;
  final dynamic parenCategory;
  final bool? isActive;
  final String? createdBy;
  final DateTime? createdAt;
  final int productCount;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      parenCategory: json["parenCategory"],
      isActive: json["isActive"],
      createdBy: json["createdBy"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      productCount: json["productCount"] ?? 0,
    );
  }

  factory Category.empty() {
    return Category(
      id: '',
      name: '',
      description: '',
      parenCategory: '',
      isActive: false,
      createdBy: '',
      createdAt: DateTime.now(),
      productCount: 0,
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $parenCategory, $isActive, $createdBy, $createdAt, ";
  }
}
