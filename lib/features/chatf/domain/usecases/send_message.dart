
import 'package:coachyp/features/chatf/domain/repo/chat_repository.dart';

import '../entities/chat_message.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call(ChatMessage message) => repository.sendMessage(message);
}
