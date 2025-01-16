import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/providers/auth_provider.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/utils/colors.dart';

class PremiumSuccessScreen extends ConsumerWidget {
  const PremiumSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(
        title: const PopilotAppbar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Felicidades!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.erieblack,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '¡Has activado tu cuenta Premium!',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.erieblack,
              ),
            ),
            const SizedBox(height: 32),
            Image.asset(
              'assets/images/premium_success.png',
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lapislazuli,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                final String token = (await storage.read(key: 'token')) ?? '';

                if (token.isNotEmpty) {
                  await authNotifier.getLoggedUser(token);
                  context.go('/home');
                }
              },
              child: const Text(
                'Ir a inicio',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
