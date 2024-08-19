import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_event.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_state.dart';
import 'package:soul_sphere/presentation/feature/home/widget/x_ball/xball_view.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider<UserBloc>.value(
        value: userBloc,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 8),
              child: Text(
                AppConstants.explore,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: AppConstants.cardItems.length,
                  itemBuilder: (context, index) {
                    final cardItem = AppConstants.cardItems[index];
                    return GestureDetector(
                      onTap: () {
                        context.go(cardItem.route);
                      },
                      child: Card(
                        color: cardItem.color,
                        elevation: 4.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              cardItem.imageUrl,
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(height: 8.0),
                            Text(cardItem.text),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
