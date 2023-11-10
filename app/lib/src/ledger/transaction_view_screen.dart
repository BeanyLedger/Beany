import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/render/render.dart';
import 'package:flutter/material.dart';

class TransactionViewScreen extends StatelessWidget {
  final Transaction tr;

  const TransactionViewScreen(this.tr, {super.key});

  @override
  Widget build(BuildContext context) {
    var text = render(tr);

    var body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Center(child: body),
    );
  }
}
