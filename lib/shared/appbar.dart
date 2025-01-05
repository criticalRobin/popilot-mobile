import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';
import 'package:popilot_mobile/utils/colors.dart';

class PopilotAppbar extends ConsumerStatefulWidget {
  const PopilotAppbar({super.key});

  @override
  ConsumerState<PopilotAppbar> createState() => _PopilotAppbarState();
}

class _PopilotAppbarState extends ConsumerState<PopilotAppbar> {
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);
    final authState = ref.watch(authProvider);

    return Row(
      children: [
        Image(
          image: AssetImage('assets/images/popilot.png'),
          fit: BoxFit.cover,
          height: 45,
          width: 125,
        ),
        const Spacer(),
        Text(authState.user?.username ?? 'usuario'),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: AppColors.erieblack,
          ),
          onPressed: () async {
            await authNotifier.signOut();
            context.go('/');
          },
        ),
      ],
    );
  }
}
