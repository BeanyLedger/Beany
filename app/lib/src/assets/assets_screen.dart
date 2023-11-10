import 'package:beany/src/bottom_bar.dart';
import 'package:flutter/material.dart';

class AssetsScreen extends StatelessWidget {
  static const routeName = '/assets';

  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      bottomNavigationBar: const BeanyBottomBar(),
    );
  }
}
