import 'package:beany_backend/beany_backend.dart';
import 'package:flutter/material.dart';
import 'package:beany_core/core/transaction.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
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
        title: const Text('Sample Items'),
        actions: const [],
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
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

/*


                showDateRangePickerDialog(
                  context: context,
                  builder: datePickerBuilder,
                );
                
Widget datePickerBuilder(
    BuildContext context, dynamic Function(DateRange) onDateRangeChanged) {
  var selectedDateRange = DateRange(
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now(),
  );

  var now = DateTime.now();
  return DateRangePickerWidget(
    doubleMonth: false,
    initialDateRange: selectedDateRange,
    maxDate: now,
    onDateRangeChanged: (_) {},
    quickDateRanges: [
      QuickDateRange(
        label: "This Month",
        dateRange: DateRange(
          DateTime(now.year, now.month),
          DateTime.now(),
        ),
      ),
      QuickDateRange(
        label: "Last Month",
        dateRange: DateRange(
          DateTime(now.year, now.month - 1),
          DateTime(now.year, now.month, 0),
        ),
      ),
      QuickDateRange(
        label: "Last 3 Months",
        dateRange: DateRange(
          DateTime(now.year, now.month - 3),
          DateTime.now(),
        ),
      ),
      QuickDateRange(
        label: "This Year",
        dateRange: DateRange(
          DateTime(now.year),
          DateTime.now(),
        ),
      ),
    ],
  );
}
*/