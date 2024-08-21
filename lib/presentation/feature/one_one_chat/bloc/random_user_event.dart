import 'package:equatable/equatable.dart';

abstract class RandomUserEvent extends Equatable {
  const RandomUserEvent();

  @override
  List<Object> get props => [];
}

class FetchRandomUser extends RandomUserEvent {}
