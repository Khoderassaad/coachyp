import 'package:coachyp/features/messaging/domain/entities/message_entity.dart';

abstract class GetMessagesUseCase {
  Future<List<Message>> execute(String userId);
}
