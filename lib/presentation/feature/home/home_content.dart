import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_event.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_state.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late final UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = GetIt.I<UserBloc>();
    userBloc.add(const LoadRandomUsers(20));
  }

  void _refreshUsers() {
    userBloc.add(const LoadRandomUsers(20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider<UserBloc>.value(
        value: userBloc,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserInitial) {
                        return const Center(child: Text('Loading...'));
                      } else if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoaded) {
                        return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              title: Text(Utils.truncateId(user.id)),
                              onTap: () {
                                context.push(
                                    '${AppPaths.userDetailPagePath}/${user.id}');
                              },
                            );
                          },
                        );
                      } else if (state is UserError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const Center(child: Text('Unknown state'));
                      }
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: _refreshUsers,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.purple,
                  padding: const EdgeInsets.all(16),
                  elevation: 6,
                ),
                child: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
