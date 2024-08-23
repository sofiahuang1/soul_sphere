import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatBloc() : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<UpdateMessages>(_onUpdateMessages);
  }

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      _firestore
          .collection('chats')
          .doc(event.chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        final messages = snapshot.docs
            .map((doc) => ChatMessage.fromFirestore(doc.data(), doc.id))
            .toList();
        add(UpdateMessages(messages));
      });
    } catch (e) {
      emit(ChatError("Failed to load messages: ${e.toString()}"));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    try {
      String? mediaUrl;

      if (event.mediaFile != null) {
        mediaUrl = await _uploadFile(
            event.mediaFile!, 'media/${DateTime.now().toIso8601String()}');
      }

      final messageId = _firestore.collection('chats').doc().id;

      final message = ChatMessage(
        id: messageId,
        senderId: event.senderId,
        receiverId: event.receiverId,
        text: event.text,
        mediaUrl: mediaUrl,
        timestamp: DateTime.now(),
        type: event.type,
      );

      final chatDoc = _firestore.collection('chats').doc(event.chatId);

      await chatDoc
          .collection('messages')
          .doc(messageId)
          .set(message.toFirestore());

      final senderOverview = ChatMessage(
        id: messageId,
        senderId: event.senderId,
        receiverId: event.receiverId,
        text: event.text,
        mediaUrl: mediaUrl,
        timestamp: DateTime.now(),
        type: event.type,
      );

      final receiverOverview = ChatMessage(
        id: messageId,
        senderId: event.senderId,
        receiverId: event.receiverId,
        text: event.text,
        mediaUrl: mediaUrl,
        timestamp: DateTime.now(),
        type: event.type,
      );

      await _firestore
          .collection('users')
          .doc(event.senderId)
          .collection('chats')
          .doc(event.chatId)
          .set(senderOverview.toFirestore(), SetOptions(merge: true));

      await _firestore
          .collection('users')
          .doc(event.receiverId)
          .collection('chats')
          .doc(event.chatId)
          .set(receiverOverview.toFirestore(), SetOptions(merge: true));
    } catch (e) {
      emit(ChatError("Failed to send message: ${e.toString()}"));
    }
  }

  void _onUpdateMessages(UpdateMessages event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.messages));
  }

  Future<String> _uploadFile(File file, String path) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(path);
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload file: ${e.toString()}");
    }
  }
}
