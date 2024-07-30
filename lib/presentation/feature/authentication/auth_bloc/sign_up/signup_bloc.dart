import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/app/utils/validate_email.dart';
import 'package:soul_sphere/app/utils/validate_password.dart';
import 'package:soul_sphere/app/utils/validate_username.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<UsernameChanged>((event, emit) {
      final usernameError = validateUsername(event.username);
      emit(state.copyWith(
          username: event.username, usernameError: usernameError));
    });

    on<EmailChanged>((event, emit) {
      final emailError = validateEmail(event.email);
      emit(state.copyWith(email: event.email, emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = validatePassword(event.password);
      emit(state.copyWith(
          password: event.password, passwordError: passwordError));
    });

    on<SignupSubmitted>((event, emit) async {
      final usernameError = state.username.isEmpty
          ? AppConstants.usernameEmpty
          : validateUsername(state.username);
      final emailError = state.email.isEmpty
          ? AppConstants.emailEmpty
          : validateEmail(state.email);
      final passwordError = state.password.isEmpty
          ? AppConstants.passwordEmpty
          : validatePassword(state.password);

      emit(state.copyWith(
          usernameError: usernameError,
          emailError: emailError,
          passwordError: passwordError));

      if (usernameError == null &&
          emailError == null &&
          passwordError == null) {
        emit(state.copyWith(isSubmitting: true));
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
