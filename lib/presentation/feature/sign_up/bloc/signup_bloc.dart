import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/utils/validator.dart';
import 'package:soul_sphere/domain/usecase/sign_up_usecase.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase signUpUseCase;

  SignupBloc({required this.signUpUseCase}) : super(const SignupState()) {
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

      String? emailError;
      String? passwordError;

      if (event.email.isEmpty) {
        emailError = 'Email cannot be empty';
      } else {
        emailError = Validators.validateEmail(event.email);
      }

      if (event.password.isEmpty) {
        passwordError = 'Password cannot be empty';
      } else {
        passwordError = Validators.validatePassword(event.password);
      }

      if (emailError != null || passwordError != null) {
        emit(state.copyWith(
          isSubmitting: false,
          emailError: emailError,
          passwordError: passwordError,
        ));
        return;
      }

      try {
        final user = await signUpUseCase(event.email, event.password);
        emit(state.copyWith(isSubmitting: false, isSuccess: true, user: user));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}
