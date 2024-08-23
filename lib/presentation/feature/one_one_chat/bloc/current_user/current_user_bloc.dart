import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/data/datasource/local_data_source/local_datasource.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final LocalDataSource _localDataSource = GetIt.I<LocalDataSource>();

  CurrentUserBloc() : super(UserIdInitial()) {
    on<LoadUserId>((event, emit) async {
      try {
        final userId = await _localDataSource.getUserId();
        emit(UserIdLoaded(userId!));
      } catch (e) {
        emit(UserIdError('Failed to load user ID'));
      }
    });
  }
}
