import 'package:flutter/material.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blueAccent : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12.0),
              topRight: const Radius.circular(12.0),
              bottomLeft:
                  isCurrentUser ? const Radius.circular(12.0) : Radius.zero,
              bottomRight:
                  isCurrentUser ? Radius.zero : const Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (message.mediaUrl != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Image.network(message.mediaUrl!),
                ),
              Text(
                message.text,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
