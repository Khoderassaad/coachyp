class UserModel {
final String uid;
final String username;
final String Email;
final String password;

  UserModel({
    required this.uid,
    required this.username,
    required this.Email,
    required this.password});


toJson(){
  return {
    "username":username,
    "Email":Email,
    "password":password,
  };
}
}