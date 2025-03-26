import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coachyp/features/messeging/domain/entities/Message_entity.dart';

class MessageProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  // Fetch messages from Firestore
  void fetchMessages() {
    _firestore.collection('messages').orderBy('timestamp', descending: true).snapshots().listen((snapshot) {
      _messages = snapshot.docs.map((doc) {
        return Message(
          id: doc.id,
          senderId: doc['senderId'],
          receiverId: doc['receiverId'],
          message: doc['message'],
          timestamp: (doc['timestamp'] as Timestamp).toDate(),
          status: doc['status'],
        );
      }).toList();
      notifyListeners(); // Update UI when data changes
    });
  }

  // Send a message to Firestore
  Future<void> sendMessage(Message message) async {
    await _firestore.collection('messages').add({
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'message': message.message,
      'timestamp': Timestamp.fromDate(message.timestamp),
      'status': message.status,
    });
  }
}
