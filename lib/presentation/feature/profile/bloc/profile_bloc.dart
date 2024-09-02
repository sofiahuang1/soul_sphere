import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/domain/usecase/get_user_profile_usecase.dart.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileBloc({required this.getUserProfileUseCase}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      final user = await getUserProfileUseCase.call(event.userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(const ProfileError('Failed to load profile data'));
    }
  }
}
