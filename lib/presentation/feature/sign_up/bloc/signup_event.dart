import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChanged extends SignupEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends SignupEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class SignupSubmitted extends SignupEvent {}
