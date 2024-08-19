import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadRandomUsers extends UserEvent {
  final int count;

  const LoadRandomUsers(this.count);

  @override
  List<Object> get props => [count];
}
