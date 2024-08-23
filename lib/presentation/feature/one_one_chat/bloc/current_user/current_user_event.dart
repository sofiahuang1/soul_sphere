import 'package:equatable/equatable.dart';

abstract class CurrentUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserId extends CurrentUserEvent {}
