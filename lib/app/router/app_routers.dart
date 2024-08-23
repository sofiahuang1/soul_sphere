import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/presentation/feature/onboarding/introduction_screen.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/widget/chat_screen/chat_screen.dart';
import 'package:soul_sphere/presentation/screens.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppPaths.splashPath,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppPaths.onBoardingPath,
      builder: (context, state) => const IntroductionScreen(),
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
      path: AppPaths.oneOneChatPath,
      builder: (context, state) => const OneOneChat(),
    ),
    GoRoute(
      path: AppPaths.interestGroupPath,
      builder: (context, state) => const InterestGroupScreen(),
    ),
    GoRoute(
      path: AppPaths.oneOneVoicePath,
      builder: (context, state) => const OneOneVoice(),
    ),
    GoRoute(
      path: AppPaths.chatScreenPath,
      builder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        final String currentUserId = extra['currentUserId'] as String;
        final UserEntity randomUser = extra['randomUser'] as UserEntity;

        return ChatScreen(
          currentUserId: currentUserId,
          randomUser: randomUser,
        );
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
          builder: (context, state) => const AllChatScreen(),
        ),
        GoRoute(
          path: AppPaths.navPaths[3],
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
