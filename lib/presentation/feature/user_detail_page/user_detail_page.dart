import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/domain/repository/user_repository.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_state.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/no_posts_placeholder.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_bloc.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_event.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/bloc/user_detail_state.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/widget/user_detail_bottom_navigation_bar.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/widget/user_header.dart';

class UserDetailPage extends StatelessWidget {
  final String userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final userRepository = GetIt.instance<UserRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserDetailBloc(userRepository)..add(LoadUser(userId)),
        ),
        BlocProvider(
          create: (context) => CurrentUserBloc()..add(LoadUserId()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, userDetailState) {
            return BlocBuilder<CurrentUserBloc, CurrentUserState>(
              builder: (context, currentUserState) {
                if (userDetailState is UserDetailLoading ||
                    currentUserState is UserIdInitial ||
                    currentUserState is UserIdLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userDetailState is UserDetailError ||
                    currentUserState is UserIdError) {
                  return Center(
                    child: Text(
                      'Error: ${userDetailState is UserDetailError ? userDetailState.message : currentUserState is UserIdError ? currentUserState.message : "Unknown error"}',
                    ),
                  );
                } else if (userDetailState is UserDetailLoaded &&
                    currentUserState is UserIdLoaded) {
                  final user = userDetailState.user;
                  final currentUserId = currentUserState.userId;
                  return Column(
                    children: [
                      UserHeader(user: user),
                      const SizedBox(height: 65),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(46.0),
                          child: NoPostsPlaceholder(),
                        ),
                      ),
                      UserDetailBottomNavigationBar(
                        user: user,
                        currentUserId: currentUserId,
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}
