import 'package:beany/src/bottom_bar.dart';
import 'package:flutter/material.dart';

class CashScreen extends StatelessWidget {
  static const routeName = '/cash';

  const CashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cash'),
      ),
      bottomNavigationBar: const BeanyBottomBar(),
    );
  }
}
