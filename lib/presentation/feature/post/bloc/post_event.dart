import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageEvent extends PostEvent {}

class SubmitPostEvent extends PostEvent {
  final String text;
  final File? image;

  SubmitPostEvent({required this.text, this.image});

  @override
  List<Object?> get props => [text, image];
}

class EditPostEvent extends PostEvent {
  final String postId;
  final String newText;
  final File? newImage;

  EditPostEvent({required this.postId, required this.newText, this.newImage});

  @override
  List<Object?> get props => [postId, newText, newImage];
}

class DeletePostEvent extends PostEvent {
  final String postId;

  DeletePostEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class LikePostEvent extends PostEvent {
  final String postId;

  LikePostEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class CommentOnPostEvent extends PostEvent {
  final String postId;
  final String comment;

  CommentOnPostEvent({required this.postId, required this.comment});

  @override
  List<Object?> get props => [postId, comment];
}

class LoadAllPostsEvent extends PostEvent {}

class LoadUserPostsEvent extends PostEvent {
  final String userId;

  LoadUserPostsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
