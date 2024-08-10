import 'package:equatable/equatable.dart';
import 'package:soul_sphere/data/model/email.dart';
import 'package:soul_sphere/data/model/password.dart';

enum SignUpStatus {
  pure,
  valid,
  invalid,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final SignUpStatus status;

  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = SignUpStatus.pure,
  });

  SignUpState copyWith({
    Email? email,
    Password? password,
    SignUpStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, status];
}
