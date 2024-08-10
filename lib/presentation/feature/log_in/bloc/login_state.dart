import 'package:equatable/equatable.dart';
import 'package:soul_sphere/data/model/email.dart';
import 'package:soul_sphere/data/model/password.dart';

enum LoginStatus {
  pure,
  valid,
  invalid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final LoginStatus status;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = LoginStatus.pure,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, status];
}
