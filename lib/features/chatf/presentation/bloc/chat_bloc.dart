import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';

class ChatBloc extends Cubit<List<ChatMessage>> {
  final GetMessages getMessages;
  final SendMessage sendMessage;

  ChatBloc({required this.getMessages, required this.sendMessage})
      : super([]) {
    getMessages().listen((messages) => emit(messages));
  }

  void send(String text, String userId) {
    sendMessage(ChatMessage(
      id: '',
      text: text,
      senderId: userId,
      timestamp: DateTime.now(),
    ));
  }
}
