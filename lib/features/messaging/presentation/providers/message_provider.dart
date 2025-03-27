import 'package:flutter/material.dart';
import 'package:coachyp/features/messaging/domain/entities/Message_entity.dart';
import 'package:coachyp/features/messaging/domain/Repositories/MessageRepository.dart';

class MessageProvider with ChangeNotifier {
  final MessageRepository _messageRepository;
  List<Message> _messages = [];
  bool _isLoading = false;

  // Constructor
  MessageProvider(this._messageRepository);

  // Getters
  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  // Fetch Messages (example with a user ID)
  Future<void> fetchMessages() async {
    _isLoading = true;
    notifyListeners();
    try {
      _messages = await _messageRepository.getMessages('userId');  // Replace with actual user ID
    } catch (e) {
      print("Error fetching messages: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Send Message
  Future<void> sendMessage(Message message) async {
    try {
      await _messageRepository.sendMessage(message); // Call the repository to send the message
      _messages.add(message);  // Add the sent message to the local list
      notifyListeners();  // Notify listeners to update the UI
    } catch (e) {
      print("Error sending message: $e");
      // Optionally handle error (e.g., show a snackbar)
    }
  }
}
