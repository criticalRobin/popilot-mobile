import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/create_update_facebook/create_update_fb_form.dart';

class CreateUpdateFacebookScreen extends ConsumerStatefulWidget {
  const CreateUpdateFacebookScreen({super.key});

  @override
  ConsumerState<CreateUpdateFacebookScreen> createState() =>
      _CreateUpdateFacebookScreenState();
}

class _CreateUpdateFacebookScreenState
    extends ConsumerState<CreateUpdateFacebookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PopilotAppbar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 32,
                          color: AppColors.lapislazuli,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Conectar Facebook',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.erieblack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ingresa los datos de tu página de Facebook para conectarla con PoPilot',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.erieblack,
                      ),
                    ),
                  ],
                ),
              ),

              // Form section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.lapislazuli.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const CreateUpdateFbForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
