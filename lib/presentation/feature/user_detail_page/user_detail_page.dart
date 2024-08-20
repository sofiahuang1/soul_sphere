import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/domain/repository/user_repository.dart';
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

    return BlocProvider(
      create: (context) =>
          UserDetailBloc(userRepository)..add(LoadUser(userId)),
      child: Scaffold(
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is UserDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is UserDetailLoaded) {
              final user = state.user;
              return Column(
                children: [
                  UserHeader(
                    user: user,
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(46.0),
                      child: NoPostsPlaceholder(),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No user data available'));
          },
        ),
        bottomNavigationBar: const UserDetailBottomNavigationBar(),
      ),
    );
  }
}
