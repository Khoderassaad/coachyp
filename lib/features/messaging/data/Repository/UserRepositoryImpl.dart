import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:coachyp/features/messaging/domain/entities/user_entity.dart';
import 'package:coachyp/features/messaging/domain/repositories/userrepository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;

  UserRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> saveUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      debugPrint("Firebase Error saving user: ${e.message}");
      throw Exception("Failed to save user: ${e.message}");
    } catch (e) {
      debugPrint("Error saving user: $e");
      throw Exception("Failed to save user: $e");
    }
  }

  @override
  Future<User> getUser(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      return User.fromJson(userDoc.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      debugPrint("Firebase Error fetching user: ${e.message}");
      throw Exception("Failed to fetch user: ${e.message}");
    } catch (e) {
      debugPrint("Error fetching user: $e");
      throw Exception("Failed to fetch user: $e");
    }
  }

  @override
  Future<void> updateUserFCMToken(String userId, String fcmToken) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': fcmToken,
      });
    } on FirebaseException catch (e) {
      debugPrint("Firebase Error updating FCM token: ${e.message}");
      throw Exception("Failed to update FCM token: ${e.message}");
    } catch (e) {
      debugPrint("Error updating FCM token: $e");
      throw Exception("Failed to update FCM token: $e");
    }
  }
}
