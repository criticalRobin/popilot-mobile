import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';
import 'package:popilot_mobile/providers/post_provider.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/shared/bottom_navigation.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/premium/premium_card.dart';
import 'package:popilot_mobile/widgets/post/post_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postProvider.notifier).fetchScheduledPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final scheduledPosts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PopilotAppbar(),
      ),
      body: authState.isPremiumUser == false
          ? const PremiumCard()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Tus próximos posts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.erieblack,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: scheduledPosts.length,
                    itemBuilder: (context, index) {
                      final post = scheduledPosts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: PostCard(post: post),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const PopilotBottomNavigationBar(),
    );
  }
}
