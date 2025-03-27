// lib/features/messaging/domain/repositories/message_repository.dart
import 'package:coachyp/features/messaging/domain/entities/Message_entity.dart';

// message_repository.dart
abstract class MessageRepository {
  Future<void> sendMessage(Message message);
  Future<void> updateMessageStatus(String messageId, String status);
  Future<List<Message>> getMessages(String userId);
}
