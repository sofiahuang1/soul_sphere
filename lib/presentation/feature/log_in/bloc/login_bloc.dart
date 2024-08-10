import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/data/model/email.dart';
import 'package:soul_sphere/data/model/password.dart';
import 'package:soul_sphere/domain/repository/authentication_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: _validateState(email, state.password),
    ));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: _validateState(state.email, password),
    ));
  }

  LoginStatus _validateState(Email email, Password password) {
    if (!email.isValid || !password.isValid) {
      return LoginStatus.invalid;
    }
    return LoginStatus.valid;
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.status == LoginStatus.valid) {
      emit(state.copyWith(status: LoginStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: LoginStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: LoginStatus.submissionFailure));
      }
    }
  }
}
