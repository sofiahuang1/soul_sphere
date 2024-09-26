import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/domain/repository/user_repository.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_event.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository userRepository;

  UserDetailBloc(this.userRepository) : super(UserDetailInitial()) {
    on<LoadUser>(_onLoadUser);
    on<FollowUser>(_onFollowUser);
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

  Future<void> _onFollowUser(
      FollowUser event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      await userRepository.followUser(event.currentUserId, event.userId);

      final updatedUser = await userRepository.getUserById(event.userId);

      emit(UserDetailLoaded(updatedUser));
    } catch (e) {
      emit(UserDetailError('Failed to follow user: ${e.toString()}'));
    }
  }
}
