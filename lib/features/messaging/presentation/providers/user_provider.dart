import 'package:flutter/material.dart';
import 'package:coachyp/features/messaging/domain/entities/user_entity.dart';
import 'package:coachyp/features/messaging/domain/repositories/userrepository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository;
  User? _user;

  UserProvider(this._userRepository);

  User? get user => _user;

  Future<void> fetchUser(String userId) async {
    try {
      _user = await _userRepository.getUser(userId);
      notifyListeners(); // Notify UI to update when user is fetched
    } catch (error) {
      print("Error fetching user: $error");
    }
  }

  // More user-related methods like updateUser, saveUser etc.
}
