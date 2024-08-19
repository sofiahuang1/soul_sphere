import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/feature/home/widget/float_builder.dart';
import 'package:soul_sphere/presentation/feature/home/widget/nav_items.dart';
import 'package:soul_sphere/presentation/feature/home/widget/navigator_builder.dart';
import 'package:soul_sphere/presentation/widgets/nav_bar.dart';
import 'package:soul_sphere/presentation/widgets/nav_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> homeNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> momentNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> chatNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  late List<NavModel> items;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    items = getNavItems(homeNavKey, momentNavKey, chatNavKey, profileNavKey);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    return _onWillPop();
  }

  Future<bool> _onWillPop() async {
    if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
      items[selectedTab].navKey.currentState?.pop();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedTab,
        children: items.map((page) => buildNavigator(page)).toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: NavBar(
        pageIndex: selectedTab,
        onTap: _onNavBarTap,
      ),
    );
  }

  void _onNavBarTap(int index) {
    if (index == selectedTab) {
      items[index].navKey.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        selectedTab = index;
      });
    }
  }
}
