import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/utils/validator.dart';
import 'package:soul_sphere/domain/repository/authentication_repository.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required AuthenticationRepository authenticationRepository})
      : super(const SignupState()) {
    on<EmailChanged>((event, emit) {
      final emailError = Validators.validateEmail(event.email);
      emit(state.copyWith(emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = Validators.validatePassword(event.password);
      emit(state.copyWith(passwordError: passwordError));
    });

    on<SignupSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 2));
      if (state.emailError == null && state.passwordError == null) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
