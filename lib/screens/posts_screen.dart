import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/providers/post_provider.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/shared/bottom_navigation.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/post/post_card.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postProvider.notifier).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PopilotAppbar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tus posts publicados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.erieblack,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
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
