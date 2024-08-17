import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_event.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_state.dart';
import 'package:soul_sphere/presentation/feature/home/widget/xball_view.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late final UserBloc userBloc;
  String? selectedUserId;

  @override
  void initState() {
    super.initState();
    userBloc = GetIt.I<UserBloc>();
    userBloc.add(const LoadRandomUsers(33));
  }

  void _refreshUsers() {
    userBloc.add(const LoadRandomUsers(33));
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
                        selectedUserId ??= state.users.first.id;
                        return XBallView(
                          mediaQueryData: MediaQuery.of(context),
                          keywords: state.users
                              .map((user) => user.id.substring(0, 4))
                              .toList(),
                          highlight: const [],
                          userId: selectedUserId!,
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
