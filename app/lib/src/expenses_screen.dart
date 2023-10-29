import 'package:beany/src/drawer.dart';
import 'package:beany_backend/beany_backend.dart' as bb;
import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/misc/date.dart';
import 'package:flutter/material.dart';

import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

import 'package:fl_chart/fl_chart.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  static const routeName = '/expenses';

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  DateRange? dateRange;
  AccountBalanceNode? balance;

  @override
  void initState() {
    var now = DateTime.now();
    dateRange = DateRange(
      DateTime(now.year, now.month),
      DateTime.now(),
    );

    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    var client = bb.BeanyHttpClient('http://127.0.0.1:8080');
    balance = await client.balance(
      Account("Expenses"),
      dateRange: bb.DateRange(
        startDate: Date.truncate(dateRange!.start),
        endDate: Date.truncate(dateRange!.end),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: const [],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              if (dateRange != null)
                Text(
                  "Date Range: ${dateRange!.start.toIso8601String().substring(0, 10)} - ${dateRange!.end.toIso8601String().substring(0, 10)}",
                ),
              TextButton(
                onPressed: () async {
                  var dateRange = await showDateRangePickerDialog(
                    context: context,
                    builder: datePickerBuilder,
                  );
                  _onDateRangeChanged(dateRange);
                },
                child: const Text("Configure Date Range"),
              ),
              const SizedBox(height: 24),
              if (balance != null) BalancePieChart(balance: balance!),
            ],
          ),
        ),
      ),
    );
  }

  void _onDateRangeChanged(DateRange? newDateRange) {
    if (newDateRange == null) return;
    dateRange = newDateRange;
    setState(() {});

    _initAsync();
  }

  Widget datePickerBuilder(
    BuildContext context,
    void Function(DateRange?) onDateRangeChanged,
  ) {
    var now = DateTime.now();
    return DateRangePickerWidget(
      doubleMonth: false,
      initialDateRange: dateRange,
      maxDate: now,
      onDateRangeChanged: onDateRangeChanged,
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
}

class BalancePieChart extends StatefulWidget {
  final AccountBalanceNode balance;

  const BalancePieChart({super.key, required this.balance});

  @override
  State<StatefulWidget> createState() => BalancePieChartState();
}

class BalancePieChartState extends State<BalancePieChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
              show: true, border: Border.all(width: 2, color: Colors.black)),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var totalEur = widget.balance.totalValue.val("EUR");
    if (totalEur == null) return const [];

    const colors = [
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];

    var dataList = <PieChartSectionData>[];
    for (var i = 0; i < widget.balance.children.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 220.0 : 200.0;

      var bal = widget.balance.children[i];
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      var value = bal.totalValue.val("EUR")!;

      var data = PieChartSectionData(
        color: colors[i % colors.length],
        value: (value / totalEur).toDouble() * 100,
        title: bal.account.parts().last,

        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        ),
        // badgeWidget: _Badge(
        //   'assets/icons/ophthalmology-svgrepo-com.svg',
        //   size: widgetSize,
        //   borderColor: AppColors.contentColorBlack,
        // ),
        badgePositionPercentageOffset: 1.2,
      );
      dataList.add(data);
    }

    return dataList;
  }
}
