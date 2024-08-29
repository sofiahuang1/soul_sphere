import 'dart:io';

import 'package:equatable/equatable.dart';

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
