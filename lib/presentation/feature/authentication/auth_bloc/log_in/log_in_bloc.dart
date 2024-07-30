import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/app/utils/validate_email.dart';
import 'package:soul_sphere/app/utils/validate_password.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_event.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      final emailError = validateEmail(event.email);
      emit(state.copyWith(email: event.email, emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = validatePassword(event.password);
      emit(state.copyWith(
          password: event.password, passwordError: passwordError));
    });

    on<LoginSubmitted>((event, emit) async {
      final emailError = state.email.isEmpty
          ? AppConstants.emailEmpty
          : validateEmail(state.email);
      final passwordError = state.password.isEmpty
          ? AppConstants.passwordEmpty
          : validatePassword(state.password);

      emit(
          state.copyWith(emailError: emailError, passwordError: passwordError));

      if (emailError == null && passwordError == null) {
        emit(state.copyWith(isSubmitting: true));
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
