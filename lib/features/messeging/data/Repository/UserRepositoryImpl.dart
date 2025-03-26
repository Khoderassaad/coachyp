import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachyp/features/messeging/domain/entities/User_entity.dart';
import 'package:coachyp/features/messeging/domain/Repositories/UserRepository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'fcmToken': user.fcmToken,
      });
    } catch (e) {
      print("Error saving user: $e");
      throw Exception("Failed to save user: $e");
    }
  }

  @override
  Future<User> getUser(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('User not found');
      }
      return User(
        id: userDoc.id,
        name: userDoc['name'],
        email: userDoc['email'],
        fcmToken: userDoc['fcmToken'],
      );
    } catch (e) {
      print("Error fetching user: $e");
      throw Exception("Failed to fetch user: $e");
    }
  }

  @override
  Future<void> updateUserFCMToken(String userId, String fcmToken) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': fcmToken,
      });
    } catch (e) {
      print("Error updating FCM token: $e");
      throw Exception("Failed to update FCM token: $e");
    }
  }
}
