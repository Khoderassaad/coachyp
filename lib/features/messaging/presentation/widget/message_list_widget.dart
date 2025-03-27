import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/message_provider.dart';

class MessageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listening for changes in the message provider
    final messages = Provider.of<MessageProvider>(context).messages;

    return ListView.builder(
      reverse: true, // Display the latest messages at the bottom
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(message.message),
          subtitle: Text("From: ${message.senderId}"),
          trailing: Text(message.timestamp.toString()),
        );
      },
    );
  }
}
