// lib/features/messaging/data/repositories/message_repository_impl.dart
import 'package:coachyp/features/messaging/domain/repositories/Messagerepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachyp/features/messaging/domain/entities/message_entity.dart';

class MessageRepositoryImpl implements MessageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> sendMessage(Message message) async {
    try {
      await _firestore.collection('messages').add({
        'senderId': message.senderId,
        'receiverId': message.receiverId,
        'message': message.message,
        'timestamp': message.timestamp,
        'status': message.status,
      });
    } catch (e) {
      print("Error sending message: $e");
      throw Exception("Failed to send message: $e");
    }
  }

  @override
  Future<void> updateMessageStatus(String messageId, String status) async {
    try {
      await _firestore.collection('messages').doc(messageId).update({
        'status': status,
      });
    } catch (e) {
      print("Error updating message status: $e");
      throw Exception("Failed to update message status: $e");
    }
  }

  @override
  Future<List<Message>> getMessages(String userId) async {
    try {
      QuerySnapshot messagesSnapshot = await _firestore
          .collection('messages')
          .where('receiverId', isEqualTo: userId)
          .orderBy('timestamp')
          .get();

      return messagesSnapshot.docs.map((doc) {
        return Message(
          id: doc.id,
          senderId: doc['senderId'],
          receiverId: doc['receiverId'],
          message: doc['message'],
          timestamp: doc['timestamp'].toDate(),
          status: doc['status'],
        );
      }).toList();
    } catch (e) {
      print("Error fetching messages: $e");
      throw Exception("Failed to fetch messages: $e");
    }
  }
}
