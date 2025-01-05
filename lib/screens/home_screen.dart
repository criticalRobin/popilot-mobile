import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/shared/bottom_navigation.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: PopilotAppbar(),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            child: Text('INICIO'),
          ),
        ),
        bottomNavigationBar: PopilotBottomNavigationBar());
  }
}
