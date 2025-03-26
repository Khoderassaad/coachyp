import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coachyp/features/messeging/presentation/widget/message_input_widget.dart';
import 'package:coachyp/features/messeging/presentation/widget/message_list_widget.dart';
import '../providers/message_provider.dart';

class MessagingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch messages when the page is built
    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.fetchMessages();

    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging'),
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: MessageListWidget(),
          ),
          // Message Input Field
          MessageInputWidget(),
        ],
      ),
    );
  }
}
