import 'package:flutter/material.dart';
import 'package:streams_exercises/features/chat/chat_message.dart';
import 'package:streams_exercises/features/chat/chat_repository.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatRepository,
  });

  final ChatRepository chatRepository;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              widget.chatRepository.startSendingMessages();
            },
          ),
          const Spacer(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<ChatMessage>(
              stream: widget.chatRepository.messages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No messages yet'));
                } else {
                  final messages = <ChatMessage>[];
                  if (snapshot.hasData) {
                    messages.add(snapshot.data!);
                  }
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(messages[index].user[0]),
                        ),
                        title: Text(messages[index].user),
                        subtitle: Text(messages[index].message),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.chatRepository.dispose();
    super.dispose();
  }
}
