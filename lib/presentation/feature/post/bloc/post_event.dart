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
