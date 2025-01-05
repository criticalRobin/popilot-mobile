import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/models/social_network.dart';
import 'package:popilot_mobile/providers/social_networks_provider.dart';
import 'package:popilot_mobile/shared/notification.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/social_networks/sn_list_tile.dart';

class SnList extends ConsumerStatefulWidget {
  const SnList({super.key});

  @override
  ConsumerState<SnList> createState() => _SnListState();
}

class _SnListState extends ConsumerState<SnList> {
  @override
  Widget build(BuildContext context) {
    final future =
        ref.watch(socialNetworkProvider.notifier).getSocialNetworks();

    return Center(
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data != null) {
            final List<SocialNetworkModel> socialNetworks = [
              ...snapshot.data!.facebookAccounts,
              ...snapshot.data!.xAccounts,
            ];
            return ListView.builder(
              itemCount: socialNetworks.length,
              itemBuilder: (context, index) {
                final socialNetwork = socialNetworks[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight, // Changed gradient direction
                      colors: socialNetwork.socialNetworkType == 'FB'
                          ? [
                              AppColors.lapislazuli.withValues(alpha: 0.1),
                              AppColors.lapislazuli.withValues(alpha: 0.3),
                            ]
                          : [
                              AppColors.erieblack.withValues(alpha: 0.1),
                              AppColors.erieblack.withValues(alpha: 0.3),
                            ],
                    ),
                    borderRadius:
                        BorderRadius.circular(12), // Add rounded corners
                    border: Border.all(
                      color: socialNetwork.socialNetworkType == 'FB'
                          ? AppColors.lapislazuli.withValues(alpha: 0.3)
                          : AppColors.erieblack.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: SocialNetworksListTile(socialNetwork: socialNetwork),
                );
              },
            );
          }

          if (snapshot.data == null) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomNotification(
                    message: 'Sin redes sociales',
                    status: 'error',
                  ),
                );
              },
            );

            return const Center(
              child: Text('No hay redes sociales disponibles'),
            );
          }

          return const Center(
            child: Text('Error al cargar las redes sociales'),
          );
        },
      ),
    );
  }
}
