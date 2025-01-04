import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/screens/sign_in_screen.dart';
import 'package:popilot_mobile/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'PoPilot',
        theme: buildAppTheme(),
        home: const SignInScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
