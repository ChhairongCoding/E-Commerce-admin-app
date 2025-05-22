class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
  };
}
