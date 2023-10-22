import 'package:beany/src/drawer.dart';
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

  @override
  void initState() {
    var now = DateTime.now();
    dateRange = DateRange(
      DateTime(now.year, now.month),
      DateTime.now(),
    );

    super.initState();
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
              const PieChartSample3(),
            ],
          ),
        ),
      ),
    );
  }

  void _onDateRangeChanged(DateRange? newDateRange) {
    setState(() {
      dateRange = newDateRange;
    });
  }
}

Widget datePickerBuilder(
    BuildContext context, void Function(DateRange?) onDateRangeChanged) {
  var selectedDateRange = DateRange(
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now(),
  );

  var now = DateTime.now();
  return DateRangePickerWidget(
    doubleMonth: false,
    initialDateRange: selectedDateRange,
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

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
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
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 220.0 : 200.0;
      // final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/ophthalmology-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            // badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/librarian-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            // badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/fitness-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            // badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/icons/worker-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: AppColors.contentColorBlack,
            // ),
            // badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}
