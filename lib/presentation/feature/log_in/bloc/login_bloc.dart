import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/app/utils/validator.dart';
import 'package:soul_sphere/data/datasource/local_data_source/local_datasource.dart';
import 'package:soul_sphere/domain/usecase/login_usecase.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_event.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final LocalDataSource localDataSource = GetIt.instance<LocalDataSource>();

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
        final user = await loginUseCase(event.email, event.password);
        await localDataSource.setIsFirst(false);
        await localDataSource.setUserId(user.id);
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
