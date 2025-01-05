import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/shared/appbar.dart';

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
      body: Container(),
    );
  }
}
