class BrandResponse {
  BrandResponse({this.success, required this.data});

  final bool? success;
  final List<BrandModel> data;

  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    return BrandResponse(
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<BrandModel>.from(
              json["data"]!.map((x) => BrandModel.fromJson(x)),
            ),
    );
  }

  @override
  String toString() {
    return "$success, $data, ";
  }

  factory BrandResponse.empty() {
    return BrandResponse(data: []);
  }
}

class BrandModel {
  final String? id;
  final String? name;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalProducts;

  BrandModel({
    this.id,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.totalProducts,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
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
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'totalProducts': totalProducts,
    };
  }

  @override
  String toString() {
    return 'BrandModel(id: $id, name: $name, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, totalProducts: $totalProducts)';
  }
}