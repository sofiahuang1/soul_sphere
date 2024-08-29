import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PickImageEvent>(_onPickImageEvent);
    on<SubmitPostEvent>(_onSubmitPostEvent);
  }

  Future<void> _onPickImageEvent(
    PickImageEvent event,
    Emitter<PostState> emit,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      emit(ImagePickedState(image));
    }
  }

  Future<void> _onSubmitPostEvent(
    SubmitPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());

    try {
      String? mediaUrl;

      if (event.image != null) {
        final fileName = DateTime.now().toIso8601String().replaceAll(':', '-');
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('post_images')
            .child('$fileName.jpg');

        final uploadTask = storageRef.putFile(event.image!);
        final snapshot = await uploadTask.whenComplete(() {});
        mediaUrl = await snapshot.ref.getDownloadURL();
      }

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId') ?? '';

      final postId = FirebaseFirestore.instance.collection('posts').doc().id;

      await FirebaseFirestore.instance.collection('posts').doc(postId).set({
        'userId': userId,
        'mediaUrl': mediaUrl,
        'mediaType': event.image != null ? 'image' : 'text',
        'text': event.text,
        'createdAt': Timestamp.now(),
        'likesCount': 0,
        'commentsCount': 0,
      });

      emit(PostSuccessState());
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }
}
