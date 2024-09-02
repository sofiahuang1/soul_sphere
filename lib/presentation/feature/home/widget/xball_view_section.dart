import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_state.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/xball_view.dart';

class XBallViewSection extends StatelessWidget {
  const XBallViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return const Center(child: Text('Loading...'));
          } else if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return XBallView(
              mediaQueryData: MediaQuery.of(context),
              keywords: state.users.map((user) => user.id).toList(),
              highlight: const [],
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
