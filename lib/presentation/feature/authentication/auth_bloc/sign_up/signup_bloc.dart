import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/utils/validate_email.dart';
import 'package:soul_sphere/app/utils/validate_password.dart';
import 'package:soul_sphere/app/utils/validate_username.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<UsernameChanged>((event, emit) {
      final usernameError = validateUsername(event.username);
      emit(state.copyWith(usernameError: usernameError));
    });

    on<EmailChanged>((event, emit) {
      final emailError = validateEmail(event.email);
      emit(state.copyWith(emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = validatePassword(event.password);
      emit(state.copyWith(passwordError: passwordError));
    });

    on<SignupSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 2));
      if (state.usernameError == null &&
          state.emailError == null &&
          state.passwordError == null) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
