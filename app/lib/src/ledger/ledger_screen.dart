import 'package:beany/src/bottom_bar.dart';
import 'package:beany_backend/beany_backend.dart';
import 'package:flutter/material.dart';
import 'package:beany_core/core/transaction.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  static const routeName = '/ledger';

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();

    _initAsync();
  }

  Future<void> _initAsync() async {
    var client = BeanyHttpClient('http://127.0.0.1:8080');
    transactions = await client.transactions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ledger'),
        actions: const [],
      ),
      bottomNavigationBar: const BeanyBottomBar(),
      body: ListView.builder(
        restorationId: 'LedgerScreen',
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          final tr = transactions[index];
          return TransactionTile(tr);
        },
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction tr;

  const TransactionTile(this.tr, {super.key});

  @override
  Widget build(BuildContext context) {
    var dateStr = tr.date.toString().substring(0, 10);

    return ListTile(
      title: Text('$dateStr ${tr.narration} ${tr.payee ?? ''}'),
      leading: const CircleAvatar(
        // Display the Flutter Logo image asset.
        foregroundImage: AssetImage('assets/images/flutter_logo.png'),
      ),
      onTap: () {},
    );
  }
}
