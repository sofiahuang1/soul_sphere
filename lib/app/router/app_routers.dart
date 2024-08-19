import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/presentation/screens.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppPaths.splashPath,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppPaths.signupPath,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppPaths.loginPath,
      builder: (context, state) => const LogInScreen(),
    ),
    GoRoute(
      path: '${AppPaths.userDetailPagePath}/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return UserDetailPage(userId: userId);
      },
    ),
    GoRoute(
      path: AppPaths.navPaths[0],
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: AppPaths.navPaths[1],
          builder: (context, state) => const MomentScreen(),
        ),
        GoRoute(
          path: AppPaths.navPaths[2],
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: AppPaths.navPaths[3],
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
