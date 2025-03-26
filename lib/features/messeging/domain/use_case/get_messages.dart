import 'package:coachyp/features/messeging/domain/entities/Message_entity.dart';

abstract class GetMessagesUseCase {
  Future<List<Message>> execute(String userId);
}
