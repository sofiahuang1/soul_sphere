import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/domain/repository/user_repository.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_event.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository userRepository;

  UserDetailBloc(this.userRepository) : super(UserDetailInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  Future<void> _onLoadUser(
      LoadUser event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final user = await userRepository.getUserById(event.userId);
      emit(UserDetailLoaded(user));
    } catch (e) {
      emit(UserDetailError('Failed to load user data: ${e.toString()}'));
    }
  }
}
