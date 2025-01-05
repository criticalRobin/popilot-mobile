import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/screens/home_screen.dart';
import 'package:popilot_mobile/screens/premium_screen.dart';
import 'package:popilot_mobile/screens/sign_in_screen.dart';
import 'package:popilot_mobile/screens/sign_up_screen.dart';
import 'package:popilot_mobile/screens/social_networks_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (content, state) => SignInScreen()),
    GoRoute(path: '/sign-up', builder: (content, state) => SignUpScreen()),
    GoRoute(
      path: '/home',
      pageBuilder: (content, state) => NoTransitionPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/socials',
      pageBuilder: (content, state) => NoTransitionPage(
        child: SocialNetworksScreen(),
      ),
    ),
    GoRoute(
      path: '/premium',
      pageBuilder: (content, state) => NoTransitionPage(
        child: PremiumScreen(),
      ),
    ),
  ],
);
