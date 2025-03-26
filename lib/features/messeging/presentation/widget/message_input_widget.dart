import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coachyp/features/messeging/presentation/providers/message_provider.dart';
import 'package:coachyp/features/messeging/domain/entities/Message_entity.dart';

class MessageInputWidget extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Enter your message",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final messageContent = _messageController.text.trim();
              if (messageContent.isNotEmpty) {
                final message = Message(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  senderId: 'sender123',
                  receiverId: 'receiver456',
                  message: messageContent,
                  timestamp: DateTime.now(),
                  status: 'sent',
                );
                // Send the message using the provider
                Provider.of<MessageProvider>(context, listen: false)
                    .sendMessage(message);

                _messageController.clear(); // Clear the text input
              }
            },
          ),
        ],
      ),
    );
  }
}
