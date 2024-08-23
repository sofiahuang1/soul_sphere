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
    on<LoadMessages>((event, emit) async {
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
        emit(ChatError(e.toString()));
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        String? mediaUrl;

        if (event.mediaFile != null) {
          mediaUrl = await uploadFile(
              event.mediaFile!, 'media/${DateTime.now().toIso8601String()}');
        }

        final message = ChatMessage(
          id: '',
          senderId: event.senderId,
          receiverId: event.receiverId,
          text: event.text,
          mediaUrl: mediaUrl,
          timestamp: DateTime.now(),
          type: event.type,
        );

        await _firestore
            .collection('chats')
            .doc(event.chatId)
            .collection('messages')
            .add(message.toFirestore());
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    on<UpdateMessages>((event, emit) {
      emit(ChatLoaded(event.messages));
    });
  }

  Future<String> uploadFile(File file, String path) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
