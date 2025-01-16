import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/screens/create_post_screen.dart';
import 'package:popilot_mobile/screens/create_update_facebook_screen.dart';
import 'package:popilot_mobile/screens/create_update_x_screen.dart';
import 'package:popilot_mobile/screens/home_screen.dart';
import 'package:popilot_mobile/screens/posts_screen.dart';
import 'package:popilot_mobile/screens/premium_screen.dart';
import 'package:popilot_mobile/screens/sign_in_screen.dart';
import 'package:popilot_mobile/screens/sign_up_screen.dart';
import 'package:popilot_mobile/screens/social_network_type_create_screen.dart';
import 'package:popilot_mobile/screens/social_networks_screen.dart';
import 'package:popilot_mobile/screens/success_screen.dart';

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
        path: '/posts',
        pageBuilder: (content, state) => NoTransitionPage(
              child: PostsScreen(),
            ),
        routes: [
          GoRoute(
            path: 'add-post',
            pageBuilder: (content, state) => NoTransitionPage(
              child: CreatePostScreen(),
            ),
          ),
        ]),
    GoRoute(
      path: '/socials',
      pageBuilder: (content, state) => NoTransitionPage(
        child: SocialNetworksScreen(),
      ),
      routes: [
        GoRoute(
          path: 'type',
          pageBuilder: (content, state) => NoTransitionPage(
            child: SocialNetworkTypeCreateScreen(),
          ),
          routes: [
            GoRoute(
              path: 'facebook',
              pageBuilder: (content, state) => NoTransitionPage(
                child: CreateUpdateFacebookScreen(),
              ),
            ),
            GoRoute(
              path: 'x',
              pageBuilder: (content, state) => NoTransitionPage(
                child: CreateUpdateXScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/premium',
      pageBuilder: (content, state) => NoTransitionPage(
        child: PremiumScreen(),
      ),
    ),
    GoRoute(
      path: '/success',
      pageBuilder: (content, state) => NoTransitionPage(
        child: PremiumSuccessScreen(),
      ),
    ),
  ],
);
