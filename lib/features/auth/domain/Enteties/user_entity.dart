class UserEntity {
  final String email;
  final String username;
  final String role;
  final String status;
  
  final String? password; // optional, used only for registration

  UserEntity({
    required this.email,
    required this.username,
    required this.role,
    required this.status,
   
    this.password,
  });
}
