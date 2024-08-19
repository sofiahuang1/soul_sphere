import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;

  UserBloc(this.authRepository) : super(UserInitial()) {
    on<LoadRandomUsers>(_onLoadRandomUsers);
  }

  Future<void> _onLoadRandomUsers(
      LoadRandomUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final users = await authRepository.getRandomUsers(event.count);
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to load users: ${e.toString()}'));
    }
  }
}
