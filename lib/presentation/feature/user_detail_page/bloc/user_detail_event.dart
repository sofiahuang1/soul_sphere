import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUser extends UserDetailEvent {
  final String userId;

  LoadUser(this.userId);

  @override
  List<Object> get props => [userId];
}
