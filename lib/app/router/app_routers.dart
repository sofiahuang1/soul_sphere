import 'package:go_router/go_router.dart';
import 'package:soul_sphere/presentation/screens.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'moment',
          builder: (context, state) => const MomentScreen(),
        ),
        GoRoute(
          path: 'post',
          builder: (context, state) => const PostScreen(),
        ),
        GoRoute(
          path: 'chat',
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
