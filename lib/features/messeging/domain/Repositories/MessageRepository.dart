import 'package:coachyp/features/messeging/domain/entities/Message_entity.dart';

abstract class MessageRepository {
  Future<void> sendMessage(Message message);  // Check this line
  Future<void> updateMessageStatus(String messageId, String status);
  Future<List<Message>> getMessages(String userId);
}
