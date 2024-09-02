import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, video, audio, emoji }

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final String? mediaUrl;
  final DateTime timestamp;
  final MessageType type;
  final bool isOverview;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    this.mediaUrl,
    required this.timestamp,
    required this.type,
    this.isOverview = false,
  });

 factory ChatMessage.fromFirestore(Map<String, dynamic> data, String id) {
  return ChatMessage(
    id: id,
    senderId: data['senderId'] ?? '',
    receiverId: data['receiverId'] ?? '',
    text: data['text'] ?? '',
    mediaUrl: data['mediaUrl'],
    timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(), 
    type: MessageType.values[data['type'] ?? 0],
    isOverview: data['isOverview'] ?? false,
  );
}


  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'mediaUrl': mediaUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'type': type.index,
      'isOverview': isOverview,
    };
  }
}
