class UserModel {
final String? id;
final String Email;
final String? password;

  UserModel({
    required this.id,
    required this.Email,
    required this.password});


toJson(){
  return {
    
    "Email":Email,
    "password":password,
  };
}
}