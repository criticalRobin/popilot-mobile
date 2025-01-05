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

    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_sharp),
        label: 'Redes',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.article),
        label: 'Posts',
      ),
      if (isPremiumUser == false)
        const BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Premium',
        ),
    ];

    final currentIndex = switch (location) {
      '/home' => 0,
      '/socials' => 1,
      '/posts' => 2,
      '/premium' when isPremiumUser == false => 3,
      _ => 0,
    };

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex < items.length ? currentIndex : 0,
      onTap: (int index) {
        if (index >= items.length) return;

        final route = switch (index) {
          0 => '/home',
          1 => '/socials',
          2 => '/posts',
          3 when isPremiumUser == false => '/premium',
          _ => '/',
        };

        context.go(route);
      },
      items: items,
    );
  }
}
