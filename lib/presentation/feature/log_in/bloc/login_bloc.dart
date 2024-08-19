import 'package:bloc/bloc.dart';
import 'package:soul_sphere/app/utils/validator.dart';
import 'package:soul_sphere/domain/usecase/login_usecase.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_event.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginState()) {
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

      final emailError = Validators.validateEmail(event.email);
      final passwordError = Validators.validatePassword(event.password);

      if (emailError != null || passwordError != null) {
        emit(state.copyWith(
          isSubmitting: false,
          emailError: emailError,
          passwordError: passwordError,
        ));
        return;
      }

      try {
        final user = await loginUseCase(event.email, event.password);
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
