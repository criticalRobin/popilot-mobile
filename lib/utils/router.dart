import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/screens/sign_in_screen.dart';
import 'package:popilot_mobile/screens/sign_up_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (content, state) => SignInScreen()),
    GoRoute(path: '/sign-up', builder: (content, state) => SignUpScreen()),
  ],
);
