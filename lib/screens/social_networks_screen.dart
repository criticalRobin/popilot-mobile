import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popilot_mobile/shared/appbar.dart';
import 'package:popilot_mobile/shared/bottom_navigation.dart';
import 'package:popilot_mobile/widgets/social_networks/sn_list.dart';

class SocialNetworksScreen extends ConsumerStatefulWidget {
  const SocialNetworksScreen({super.key});

  @override
  ConsumerState<SocialNetworksScreen> createState() =>
      _SocialNetworksScreenState();
}

class _SocialNetworksScreenState extends ConsumerState<SocialNetworksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PopilotAppbar(),
      ),
      body: SnList(),
      bottomNavigationBar: PopilotBottomNavigationBar(),
    );
  }
}
