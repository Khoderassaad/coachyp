import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String fcmToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.fcmToken,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      fcmToken: json['fcmToken'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'fcmToken': fcmToken,
    };
  }

  // Create a copy of the User with optional new values
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? fcmToken,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
