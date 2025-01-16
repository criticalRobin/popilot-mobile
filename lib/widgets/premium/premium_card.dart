import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/shared/notification.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/providers/stripe_provider.dart'; // Adjust import path as needed

class PremiumCard extends ConsumerStatefulWidget {
  const PremiumCard({super.key});

  @override
  ConsumerState<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends ConsumerState<PremiumCard> {
  @override
  void initState() {
    super.initState();
    // Initialize Stripe when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stripeProvider.notifier).initialize();
    });
  }

  void _handlePayment() {
    // Trigger payment process
    ref.read(stripeProvider.notifier).createPayment();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to Stripe state
    final stripeState = ref.watch(stripeProvider);

    // Show loading dialog if payment is in progress
    if (stripeState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.lapislazuli,
            ),
          ),
        );
      });
    }

    // Handle payment success
    if (stripeState.isPaymentSuccessful) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Close any open dialogs
        Navigator.of(context, rootNavigator: true).pop();

        // Show success dialog
        ScaffoldMessenger.of(context).showSnackBar(
          CustomNotification(
            message: '¡Has activado tu cuenta Premium!',
            status: 'success',
          ),
        );

        context.go('/success');

        // Reset the state
        ref.read(stripeProvider.notifier).resetState();
      });
    }

    // Handle payment error
    if (stripeState.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Close any open dialogs
        Navigator.of(context, rootNavigator: true).pop();

        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error de Pago'),
            content: Text(stripeState.errorMessage!),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset the state
                  ref.read(stripeProvider.notifier).resetState();
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      });
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Crown emoji
              const Text(
                '👑',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Conviertete en Premium',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle with rocket emoji
              const Text(
                'No te conformes con lo que ofrece tu cuenta gratuita, ve al siguiente nivel 🚀!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.erieblack,
                ),
              ),
              const SizedBox(height: 24),

              // Image
              Image.asset(
                'assets/images/payment.png', // Make sure to add this to your pubspec.yaml
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              // Premium benefits
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Premium',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.erieblack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Con una cuenta premium vas a tener acceso a las siguientes características de PoPilot:',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.erieblack,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Benefits list
                    _buildBenefitItem('Gestión de tus redes sociales'),
                    _buildBenefitItem('Agendar posts a tus redes'),
                    _buildBenefitItem('Beneficios standard'),

                    const SizedBox(height: 24),

                    // Price
                    Center(
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.erieblack,
                                ),
                              ),
                              Text(
                                '10',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.erieblack,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Un solo pago!',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.erieblack,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: AppColors.lapislazuli,
                              ),
                              icon: const Icon(
                                Icons.payment,
                                color: AppColors.white,
                              ),
                              label: Text(
                                'Ir a Pagar',
                                style: TextStyle(color: AppColors.white),
                              ),
                              onPressed: _handlePayment,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.lapislazuli,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.erieblack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
