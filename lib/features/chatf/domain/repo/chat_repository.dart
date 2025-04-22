
import 'package:coachyp/features/chatf/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> getMessages();
  Future<void> sendMessage(ChatMessage message);
}
