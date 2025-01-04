import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/sign_up/sign_up_form.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                height: 300,
                image: AssetImage('assets/images/sign-up.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Registrate en PoPilot',
                style: TextStyle(
                    color: AppColors.erieblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SignUpForm(),
              ),
              TextButton(
                onPressed: () {
                  context.go('/');
                },
                child: const Text(
                  '¿Ya tienes una cuenta? Inicia sesión',
                  style: TextStyle(
                    color: AppColors.moonstone,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
