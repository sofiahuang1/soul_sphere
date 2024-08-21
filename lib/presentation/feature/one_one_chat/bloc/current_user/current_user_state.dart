import 'package:equatable/equatable.dart';

abstract class CurrentUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserIdInitial extends CurrentUserState {}

class UserIdLoading extends CurrentUserState {}

class UserIdLoaded extends CurrentUserState {
  final String userId;

  UserIdLoaded(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UserIdError extends CurrentUserState {
  final String message;

  UserIdError(this.message);

  @override
  List<Object?> get props => [message];
}
