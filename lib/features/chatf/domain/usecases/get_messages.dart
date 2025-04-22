import 'package:coachyp/features/chatf/domain/repo/chat_repository.dart';

import '../entities/chat_message.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Stream<List<ChatMessage>> call() => repository.getMessages();
}
