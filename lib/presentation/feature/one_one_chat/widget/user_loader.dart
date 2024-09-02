import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_state.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/random_user_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/random_user_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/random_user_state.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/widget/chat_screen/chat_screen.dart';

class UserLoader extends StatelessWidget {
  const UserLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentUserBloc()..add(LoadUserId()),
        ),
        BlocProvider(
          create: (context) =>
              GetIt.I<RandomUserBloc>()..add(FetchRandomUser()),
        ),
      ],
      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, userIdState) {
          return BlocBuilder<RandomUserBloc, RandomUserState>(
            builder: (context, randomUserState) {
              if (userIdState is UserIdLoading ||
                  randomUserState is RandomUserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (userIdState is UserIdError) {
                return Center(
                    child: Text('User ID Error: ${userIdState.message}'));
              } else if (randomUserState is RandomUserError) {
                return Center(
                    child:
                        Text('Random User Error: ${randomUserState.message}'));
              } else if (userIdState is UserIdLoaded &&
                  randomUserState is RandomUserLoaded) {
                return ChatScreen(
                  currentUserId: userIdState.userId,
                  randomUser: randomUserState.user,
                );
              } else {
                return const Center(child: Text('Something went wrong.'));
              }
            },
          );
        },
      ),
    );
  }
}
