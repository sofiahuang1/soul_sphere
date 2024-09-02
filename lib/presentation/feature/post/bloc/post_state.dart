import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:soul_sphere/domain/entities/post_entity.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class ImagePickedState extends PostState {
  final File image;

  ImagePickedState(this.image);

  @override
  List<Object?> get props => [image];
}

class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {}

class PostFailureState extends PostState {
  final String error;

  PostFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class PostEditSuccessState extends PostState {}

class PostDeleteSuccessState extends PostState {}

class PostLikeSuccessState extends PostState {}

class PostCommentSuccessState extends PostState {}

class AllPostsLoadedState extends PostState {
  final List<PostEntity> posts;

  AllPostsLoadedState(this.posts);

  @override
  List<Object?> get props => [posts];
}

class UserPostsLoadedState extends PostState {
  final List<PostEntity> posts;

  UserPostsLoadedState(this.posts);

  @override
  List<Object?> get props => [posts];
}
