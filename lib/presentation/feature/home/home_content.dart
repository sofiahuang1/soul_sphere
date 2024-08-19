import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_event.dart';
import 'package:soul_sphere/presentation/feature/home/widget/explore_text.dart';
import 'package:soul_sphere/presentation/feature/home/widget/home_card_grid_view.dart';
import 'package:soul_sphere/presentation/feature/home/widget/xball_view_section.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late final UserBloc userBloc;
  int _visibleItems = 2;

  @override
  void initState() {
    super.initState();
    userBloc = GetIt.I<UserBloc>();
    userBloc.add(const LoadRandomUsers(20));
  }

  void _loadMoreItems() {
    if (_visibleItems < AppConstants.cardItems.length) {
      _visibleItems += 2;
      setState(() {});
    }
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
            const XBallViewSection(),
            const ExploreText(),
            HomeCardGridView(
              visibleItems: _visibleItems,
              loadMoreItems: _loadMoreItems,
            ),
          ],
        ),
      ),
    );
  }
}
