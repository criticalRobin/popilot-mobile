import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/utils/colors.dart';
import 'package:popilot_mobile/widgets/sign_in/sign_in_form.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
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
                image: AssetImage('assets/images/login.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bienvenido a PoPilot',
                style: TextStyle(
                    color: AppColors.erieblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SignInForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
