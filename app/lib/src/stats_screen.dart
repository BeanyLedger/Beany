import 'package:beany/src/bottom_bar.dart';
import 'package:beany/src/stats/bloc/stats_bloc.dart';
import 'package:beany/src/stats/bloc/stats_event.dart';
import 'package:beany/src/stats/bloc/stats_state.dart';
import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/misc/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:beany_backend/beany_backend.dart' as bb;

import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  static const routeName = '/stats';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StatsScreenBloc(),
      child: Builder(builder: (context) {
        var bloc = BlocProvider.of<StatsScreenBloc>(context);
        return StatsView(bloc);
      }),
    );
  }
}

class StatsView extends StatefulWidget {
  final StatsScreenBloc bloc;

  const StatsView(this.bloc, {super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

const _startingAccount = "Expenses";

class _StatsViewState extends State<StatsView> {
  late DateRange dateRange;

  Account account = Account(_startingAccount);

  @override
  void initState() {
    var now = DateTime.now();
    dateRange = DateRange(
      DateTime(now.year, now.month),
      DateTime.now(),
    );

    widget.bloc.add(
      StatsScreenStarted(
        account,
        bb.DateRange(
          startDate: Date.truncate(dateRange.start),
          endDate: Date.truncate(dateRange.end),
        ),
      ),
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
      bottomNavigationBar: const BeanyBottomBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              // FIXME: I think maybe we should be getting exactly the range we need, as a Date
              //        This business of truncating the DateTime should not be in the presentation layer
              Text(
                "Date Range: ${dateRange.start.toIso8601String().substring(0, 10)} - ${dateRange.end.toIso8601String().substring(0, 10)}",
              ),
              const SizedBox(height: 8),
              BlocBuilder<StatsScreenBloc, StatsScreenState>(
                builder: (context, state) {
                  switch (state) {
                    case StatsScreenLoading():
                      return const CircularProgressIndicator();
                    case StatsScreenLoaded():
                      return AccountsBar(
                        account: account,
                        onAccountChanged: _onAccountChanged,
                      );
                    case StatsScreenError():
                      return Text("Error: ${state.message}");
                  }
                },
              ),
              const SizedBox(height: 8),
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
              BlocBuilder<StatsScreenBloc, StatsScreenState>(
                builder: (context, state) {
                  switch (state) {
                    case StatsScreenLoading():
                      return const CircularProgressIndicator();
                    case StatsScreenLoaded():
                      return BalancePieChart(
                        balance: state.accountBalanceNode,
                        onAccountSelected: _onAccountChanged,
                      );
                    case StatsScreenError():
                      return Text("Error: ${state.message}");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAccountChanged(Account account) {
    setState(() {
      this.account = account;
    });

    var bloc = BlocProvider.of<StatsScreenBloc>(context);
    bloc.add(
      StatsScreenStarted(
        account,
        bb.DateRange(
          startDate: Date.truncate(dateRange.start),
          endDate: Date.truncate(dateRange.end),
        ),
      ),
    );
  }

  void _onDateRangeChanged(DateRange? newDateRange) {
    if (newDateRange == null) return;
    dateRange = newDateRange;
    setState(() {});

    // _refresh();
    var bloc = BlocProvider.of<StatsScreenBloc>(context);
    bloc.add(
      StatsScreenStarted(
        account,
        bb.DateRange(
          startDate: Date.truncate(dateRange.start),
          endDate: Date.truncate(dateRange.end),
        ),
      ),
    );
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
  final void Function(Account) onAccountSelected;

  const BalancePieChart(
      {super.key, required this.balance, required this.onAccountSelected});

  @override
  State<StatefulWidget> createState() => BalancePieChartState();
}

class BalancePieChartState extends State<BalancePieChart> {
  int touchedIndex = 0;

  @override
  void didUpdateWidget(covariant BalancePieChart oldWidget) {
    if (oldWidget.balance != widget.balance) {
      touchedIndex = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              if (event is FlTapDownEvent) {
                if (pieTouchResponse?.touchedSection == null) {
                  return;
                }
                var index =
                    pieTouchResponse!.touchedSection!.touchedSectionIndex;

                var account = _child(index).account;
                widget.onAccountSelected(account);
              }

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

  AccountBalanceNode _child(int index) {
    return widget.balance.children[index];
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

class AccountsBar extends StatelessWidget {
  final Account account;
  final void Function(Account) onAccountChanged;

  const AccountsBar({
    super.key,
    required this.account,
    required this.onAccountChanged,
  });

  @override
  Widget build(BuildContext context) {
    var parts = account.parts();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < parts.length; i++) ...[
            TextButton(
              onPressed: () {
                var newAccount = Account.fromParts(parts.sublist(0, i + 1));
                onAccountChanged(newAccount);
              },
              child: Text(parts[i]),
            ),
            if (i < parts.length - 1) const Text(" > "),
          ],
        ],
      ),
    );
  }
}
