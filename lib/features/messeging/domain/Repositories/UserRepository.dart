import 'package:coachyp/features/messeging/domain/entities/User_entity.dart';

abstract class UserRepository {
  Future<void> saveUser(User user);  // Method signature
  Future<User> getUser(String userId);
  Future<void> updateUserFCMToken(String userId, String fcmToken);
}
