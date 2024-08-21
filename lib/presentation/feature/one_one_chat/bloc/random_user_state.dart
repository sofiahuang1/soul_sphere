import 'package:equatable/equatable.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';

abstract class RandomUserState extends Equatable {
  const RandomUserState();

  @override
  List<Object> get props => [];
}

class RandomUserInitial extends RandomUserState {}

class RandomUserLoading extends RandomUserState {}

class RandomUserLoaded extends RandomUserState {
  final UserEntity user;

  const RandomUserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class RandomUserError extends RandomUserState {
  final String message;

  const RandomUserError(this.message);

  @override
  List<Object> get props => [message];
}
