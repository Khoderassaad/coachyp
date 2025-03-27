import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coachyp/features/messaging/presentation/widget/message_input_widget.dart';
import 'package:coachyp/features/messaging/presentation/widget/message_list_widget.dart';
import '../providers/message_provider.dart';

class MessagingPage extends StatefulWidget {
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  void initState() {
    super.initState();
    // Fetch messages only once when the page is initialized
    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    messageProvider.fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messaging'),
      ),
      body: Consumer<MessageProvider>(
        builder: (context, messageProvider, child) {
          // The MessageListWidget will be automatically updated when the provider changes
          return Column(
            children: [
              // Message List
              Expanded(
                child: MessageListWidget(),  // No need to pass messages directly
              ),
              // Message Input Field
              MessageInputWidget(),
            ],
          );
        },
      ),
    );
  }
}
