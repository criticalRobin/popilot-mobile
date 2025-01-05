import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';

class PopilotBottomNavigationBar extends ConsumerStatefulWidget {
  const PopilotBottomNavigationBar({super.key});

  @override
  ConsumerState<PopilotBottomNavigationBar> createState() =>
      _PopilotBottomNavigationBarState();
}

class _PopilotBottomNavigationBarState
    extends ConsumerState<PopilotBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).location;
    final isPremiumUser = ref.watch(authProvider).isPremiumUser;

    int currentIndex = switch (location) {
      '/home' => 0,
      '/socials' => 1,
      '/posts' => 2,
      '/premium' => 3,
      _ => 0,
    };
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            GoRouter.of(context).go('/home');
            break;
          case 1:
            GoRouter.of(context).go('/socials');
            break;
          case 2:
            GoRouter.of(context).go('/posts');
            break;
          case 3:
            GoRouter.of(context).go('/premium');
            break;
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_sharp),
          label: 'Redes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Posts',
        ),
        if (isPremiumUser == false)
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Premium',
          ),
      ],
    );
  }
}
