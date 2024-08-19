import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  @override
  List<Object?> get props =>
      [emailError, passwordError, isSubmitting, isSuccess, isFailure];

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
