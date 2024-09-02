import 'package:equatable/equatable.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';

abstract class UserDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final UserEntity user;

  UserDetailLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserDetailError extends UserDetailState {
  final String message;

  UserDetailError(this.message);

  @override
  List<Object> get props => [message];
}
