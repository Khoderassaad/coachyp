import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repo/chat_repository.dart';
import '../models/chat_message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepositoryImpl(this.firestore);

  @override
  Stream<List<ChatMessage>> getMessages() {
    return firestore.collection('chats')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return ChatMessageModel.fromMap(doc.data(), doc.id);
          }).toList());
  }

  @override
  Future<void> sendMessage(ChatMessage message) {
    final model = ChatMessageModel(
      id: '',
      text: message.text,
      senderId: message.senderId,
      timestamp: message.timestamp,
    );
    return firestore.collection('chats').add(model.toMap());
  }
}
