import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/utils/validator.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_event.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authenticationRepository})
      : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      final emailError = Validators.validateEmail(event.email);
      emit(state.copyWith(emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = Validators.validatePassword(event.password);
      emit(state.copyWith(passwordError: passwordError));
    });

    on<LoginSubmitted>((event, emit) async {
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
