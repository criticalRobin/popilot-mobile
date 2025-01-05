import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/shared/bottom_navigation.dart';
import 'package:popilot_mobile/widgets/premium/premium_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isPremiumUser = ref.watch(authProvider).isPremiumUser;

    return Scaffold(
      appBar: AppBar(
        title: PopilotAppbar(),
      ),
      body: isPremiumUser == false
          ? PremiumCard()
          : Center(
              child: Text('Bienvenido Popilot!'),
            ),
      bottomNavigationBar: PopilotBottomNavigationBar(),
    );
  }
}
