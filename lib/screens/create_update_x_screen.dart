import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/create_update_x/create_update_x_form.dart';

class CreateUpdateXScreen extends ConsumerStatefulWidget {
  const CreateUpdateXScreen({super.key});

  @override
  ConsumerState<CreateUpdateXScreen> createState() =>
      _CreateUpdateXScreenState();
}

class _CreateUpdateXScreenState extends ConsumerState<CreateUpdateXScreen> {
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
                          Icons.close_outlined,
                          size: 32,
                          color: AppColors.erieblack,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Conectar X-Twitter',
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
                      'Ingresa los datos de tu página de X-Twitter para conectarla con PoPilot',
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
                child: const CreateUpdateXForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
