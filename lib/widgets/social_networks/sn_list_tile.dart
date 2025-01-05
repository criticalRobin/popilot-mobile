import 'package:flutter/material.dart';
import 'package:popilot_mobile/models/social_network.dart';
import 'package:popilot_mobile/utils/colors.dart';

class SocialNetworksListTile extends StatelessWidget {
  const SocialNetworksListTile({
    super.key,
    required this.socialNetwork,
  });

  final SocialNetworkModel socialNetwork;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 8), // Add padding
      leading: Icon(
        socialNetwork.socialNetworkType == 'FB'
            ? Icons.facebook
            : Icons.close_outlined,
        color: socialNetwork.socialNetworkType == 'FB'
            ? AppColors.lapislazuli
            : AppColors.erieblack,
        size: 28,
      ),
      title: Text(
        socialNetwork.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: socialNetwork.socialNetworkType == 'FB'
              ? AppColors.lapislazuli
              : AppColors.erieblack,
        ),
      ),
      subtitle: Text(
        socialNetwork.socialNetworkType == 'FB' ? 'Facebook' : 'X - Twitter',
        style: TextStyle(
          fontSize: 14,
          color: socialNetwork.socialNetworkType == 'FB'
              ? AppColors.lapislazuli.withValues()
              : AppColors.erieblack.withValues(),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: socialNetwork.socialNetworkType == 'FB'
            ? AppColors.lapislazuli
            : AppColors.erieblack,
      ),
    );
  }
}
