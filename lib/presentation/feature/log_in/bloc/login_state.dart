import 'package:equatable/equatable.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';

class LoginState extends Equatable {
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final UserEntity? user;
  final String? errorMessage;

  const LoginState({
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.user,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
        isSubmitting,
        isSuccess,
        isFailure,
        user,
        errorMessage
      ];

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    UserEntity? user,
    String? errorMessage,
  }) {
    return LoginState(
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
