import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/presentation/screens.dart';
import 'package:soul_sphere/presentation/widgets/nav_bar.dart';
import 'package:soul_sphere/presentation/widgets/nav_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final homeNavKey = GlobalKey<NavigatorState>();
  final momentNavKey = GlobalKey<NavigatorState>();
  final chatNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    items = [
      NavModel(
        page: const HomeContent(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const MomentScreen(),
        navKey: momentNavKey,
      ),
      NavModel(
        page: const ChatScreen(),
        navKey: chatNavKey,
      ),
      NavModel(
        page: const ProfileScreen(),
        navKey: profileNavKey,
      ),
    ];
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
      body: IndexedStack(
        index: selectedTab,
        children: items
            .map((page) => Navigator(
                  key: page.navKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    return [MaterialPageRoute(builder: (context) => page.page)];
                  },
                ))
            .toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 35),
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: AppColors.white,
          elevation: 0,
          onPressed: () => debugPrint("Add Button pressed"),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: AppColors.purple),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.purple,
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        pageIndex: selectedTab,
        onTap: (index) {
          if (index == selectedTab) {
            items[index]
                .navKey
                .currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            setState(() {
              selectedTab = index;
            });
          }
        },
      ),
    );
  }
}
