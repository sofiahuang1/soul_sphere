import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const SignupState({
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  @override
  List<Object?> get props =>
      [emailError, passwordError, isSubmitting, isSuccess, isFailure];

  SignupState copyWith({
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignupState(
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
