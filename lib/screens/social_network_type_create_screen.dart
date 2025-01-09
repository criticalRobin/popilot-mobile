import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/utils/colors.dart';

class SocialNetworkTypeCreateScreen extends StatelessWidget {
  const SocialNetworkTypeCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PopilotAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Qué red social quieres agregar?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.erieblack,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Selecciona el tipo de cuenta que deseas conectar con PoPilot',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.erieblack,
              ),
            ),
            const SizedBox(height: 32),
            _buildNetworkOption(
              context: context,
              type: 'Facebook',
              description: 'Conecta tu página de Facebook',
              gradient: [
                AppColors.lapislazuli.withValues(alpha: 0.1),
                AppColors.lapislazuli.withValues(alpha: 0.3),
              ],
              borderColor: AppColors.lapislazuli.withValues(alpha: 0.3),
              iconColor: AppColors.lapislazuli,
              icon: Icons.facebook,
              onTap: () => context.go('/socials/type/facebook'),
            ),
            const SizedBox(height: 16),
            _buildNetworkOption(
              context: context,
              type: 'X - Twitter',
              description: 'Conecta tu cuenta de X (Twitter)',
              gradient: [
                AppColors.erieblack.withValues(alpha: 0.1),
                AppColors.erieblack.withValues(alpha: 0.3),
              ],
              borderColor: AppColors.erieblack.withValues(alpha: 0.3),
              iconColor: AppColors.erieblack,
              icon: Icons.close_outlined,
              onTap: () => context.go('/socials/type/x'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkOption({
    required BuildContext context,
    required String type,
    required String description,
    required List<Color> gradient,
    required Color borderColor,
    required Color iconColor,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: iconColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
