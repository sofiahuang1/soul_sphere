import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/random_user_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/random_user_state.dart';

class RandomUserBloc extends Bloc<RandomUserEvent, RandomUserState> {
  final AuthRepository authRepository;

  RandomUserBloc({
    required this.authRepository,
  }) : super(RandomUserInitial()) {
    on<FetchRandomUser>((event, emit) async {
      emit(RandomUserLoading());
      try {
        final users = await authRepository.getRandomUsers(1);
        emit(RandomUserLoaded(users.first));
      } catch (e) {
        emit(RandomUserError(e.toString()));
      }
    });
  }
}
