import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/data/model/email.dart';
import 'package:soul_sphere/data/model/password.dart';
import 'package:soul_sphere/domain/repository/authentication_repository.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: _validateState(email, state.password),
    ));
  }

  void _onPasswordChanged(
      SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: _validateState(state.email, password),
    ));
  }

  SignUpStatus _validateState(Email email, Password password) {
    if (!email.isValid || !password.isValid) {
      return SignUpStatus.invalid;
    }
    return SignUpStatus.valid;
  }

  Future<void> _onSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (state.status == SignUpStatus.valid) {
      emit(state.copyWith(status: SignUpStatus.submissionInProgress));
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: SignUpStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: SignUpStatus.submissionFailure));
      }
    }
  }
}
