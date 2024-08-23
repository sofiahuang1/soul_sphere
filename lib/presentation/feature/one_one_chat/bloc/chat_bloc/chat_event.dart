import 'dart:io';

import 'package:soul_sphere/domain/model/chat_message.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String chatId;

  LoadMessages(this.chatId);
}

class SendMessage extends ChatEvent {
  final String text;
  final MessageType type;
  final String senderId;
  final String receiverId;
  final File? mediaFile;
  final String chatId;

  SendMessage({
    required this.text,
    required this.type,
    required this.senderId,
    required this.receiverId,
    this.mediaFile,
    required this.chatId,
  });
}

class UpdateMessages extends ChatEvent {
  final List<ChatMessage> messages;

  UpdateMessages(this.messages);
}
