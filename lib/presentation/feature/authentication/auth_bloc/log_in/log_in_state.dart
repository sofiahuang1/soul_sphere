class LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
