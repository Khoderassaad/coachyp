import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coachyp/features/messaging/presentation/providers/message_provider.dart';
import 'package:coachyp/features/messaging/domain/entities/Message_entity.dart';

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
                // Fetch the sender's ID from Firebase Auth (assuming the user is logged in)
                final senderId = 'sender123'; // Replace this with Firebase Auth current user ID
                final receiverId = 'receiver456'; // Replace with the actual receiver's ID, perhaps passed as an argument

                final message = Message(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  senderId: senderId,
                  receiverId: receiverId,
                  message: messageContent,
                  timestamp: DateTime.now(),
                  status: 'sent',
                );

                // Use the provider to send the message
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
