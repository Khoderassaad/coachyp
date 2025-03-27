import 'package:coachyp/features/messaging/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> saveUser(User user);
  Future<User?> getUser(String userId); // Return nullable User
  Future<bool> userExists(String userId); // New method to check existence
  Future<void> updateUserFCMToken(String userId, String fcmToken);
  Future<void> updateUserData(String userId, Map<String, dynamic> data); // Generic update method
}
