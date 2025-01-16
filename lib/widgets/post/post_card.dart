import 'package:flutter/material.dart';
import 'package:popilot_mobile/models/post.dart';
import 'package:popilot_mobile/utils/colors.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.erieblack,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              post.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.erieblack,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.scheduledAt != null)
                  Text(
                    'Agendado para: ${post.scheduledAt!.year}-${post.scheduledAt!.month.toString().padLeft(2, '0')}-${post.scheduledAt!.day.toString().padLeft(2, '0')} ${post.scheduledAt!.hour.toString().padLeft(2, '0')}:${post.scheduledAt!.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.erieblack,
                    ),
                  ),
                const SizedBox(height: 8),
                if (post.createdAt != null)
                  Text(
                    'Creado: ${post.createdAt!.year}-${post.createdAt!.month.toString().padLeft(2, '0')}-${post.createdAt!.day.toString().padLeft(2, '0')} ${post.createdAt!.hour.toString().padLeft(2, '0')}:${post.createdAt!.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.erieblack,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
