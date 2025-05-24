class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    this.parenCategory,
    required this.isActive,
  });

  final String id;
  final String name;
  final String description;
  final dynamic parenCategory;
  final bool isActive;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      parenCategory: json["parenCategory"],
      isActive: json["isActive"] ?? false,
    );
  }

  factory Category.empty() {
    return Category(
      id: '',
      name: '',
      description: '',
      parenCategory: null,
      isActive: false,
    );
  }

  @override
  String toString() {
    return "$id, $name, $description, $parenCategory, $isActive";
  }
}
