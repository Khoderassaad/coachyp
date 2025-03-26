import 'package:coachyp/features/messeging/domain/entities/Message_entity.dart';
import 'package:coachyp/features/messeging/domain/Repositories/MessageRepository.dart';

class SendMessageUseCase {
  final MessageRepository messageRepository;

  SendMessageUseCase(this.messageRepository);

  Future<void> execute(Message message) async {
    try {
      // Call the repository's send message method
      await messageRepository.sendMessage(message);
    } catch (e) {
      // Handle error here if necessary
      throw Exception("Failed to send message: $e");
    }
  }
}
