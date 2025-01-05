import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/shared/appbar.dart';

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
      body: Container(),
    );
  }
}
