import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sphere/domain/repository/post_repository.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<PickImageEvent>(_onPickImageEvent);
    on<SubmitPostEvent>(_onSubmitPostEvent);
    on<LoadAllPostsEvent>(_onLoadAllPostsEvent);
    on<LoadUserPostsEvent>(_onLoadUserPostsEvent);
    on<EditPostEvent>(_onEditPostEvent);
    on<DeletePostEvent>(_onDeletePostEvent);
    on<LikePostEvent>(_onLikePostEvent);
    on<CommentOnPostEvent>(_onCommentOnPostEvent);
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

  Future<void> _onEditPostEvent(
    EditPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());

    try {
      String? mediaUrl;

      if (event.newImage != null) {
        final fileName = DateTime.now().toIso8601String().replaceAll(':', '-');
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('post_images')
            .child('$fileName.jpg');

        final uploadTask = storageRef.putFile(event.newImage!);
        final snapshot = await uploadTask.whenComplete(() {});
        mediaUrl = await snapshot.ref.getDownloadURL();
      }

      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(event.postId);

      await postRef.update({
        'text': event.newText,
        'mediaUrl': mediaUrl,
        'mediaType': event.newImage != null ? 'image' : 'text',
      });

      emit(PostEditSuccessState());
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }

  Future<void> _onDeletePostEvent(
    DeletePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());

    try {
      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(event.postId);

      await postRef.delete();

      emit(PostDeleteSuccessState());
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }

  Future<void> _onLikePostEvent(
    LikePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());

    try {
      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(event.postId);

      await postRef.update({
        'likesCount': FieldValue.increment(1),
      });

      emit(PostLikeSuccessState());
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }

  Future<void> _onCommentOnPostEvent(
    CommentOnPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());

    try {
      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(event.postId);

      await postRef.update({
        'commentsCount': FieldValue.increment(1),
      });

      emit(PostCommentSuccessState());
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }

  Future<void> _onLoadAllPostsEvent(
    LoadAllPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      final posts = await postRepository.getAllPosts();
      emit(AllPostsLoadedState(posts));
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }

  Future<void> _onLoadUserPostsEvent(
    LoadUserPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      final posts = await postRepository.getPostsByUser(event.userId);
      emit(UserPostsLoadedState(posts));
    } catch (e) {
      emit(PostFailureState(e.toString()));
    }
  }
}
