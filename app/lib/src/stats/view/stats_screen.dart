import 'package:beany/src/bottom_bar.dart';
import 'package:beany/src/stats/bloc/stats_bloc.dart';
import 'package:beany/src/stats/bloc/stats_event.dart';
import 'package:beany/src/stats/bloc/stats_state.dart';
import 'package:beany/src/stats/view/accounts_bar.dart';
import 'package:beany/src/stats/view/beany_date_range_picker.dart';
import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/misc/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

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
  @override
  void initState() {
    var now = DateTime.now();

    widget.bloc.add(
      StatsScreenStarted(
        Account(_startingAccount),
        // FIXME: This month might not exist and we might therefore get an error
        //        Shouldn't we only be allowing date ranges that are valid?
        Date(now.year, now.month - 1),
        Date.today(),
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
      body: BlocBuilder<StatsScreenBloc, StatsScreenState>(
        builder: (context, state) {
          switch (state) {
            case StatsScreenLoading():
              return const CircularProgressIndicator();
            case StatsScreenLoaded():
              return _StatsScreenLoadedView(state);
            case StatsScreenError():
              return Text("Error: ${state.message}");
          }
        },
      ),
    );
  }
}

class _StatsScreenLoadedView extends StatefulWidget {
  final StatsScreenLoaded state;

  const _StatsScreenLoadedView(this.state);

  @override
  State<_StatsScreenLoadedView> createState() => _StatsScreenLoadedViewState();
}

class _StatsScreenLoadedViewState extends State<_StatsScreenLoadedView> {
  @override
  Widget build(BuildContext context) {
    var startDate = widget.state.startDate;
    var endDate = widget.state.endDate;
    var account = widget.state.accountBalanceNode.account;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Text(
              "Date Range: ${startDate.toIso8601String()} - ${endDate.toIso8601String()}",
            ),
            const SizedBox(height: 8),
            AccountsBar(
              account: account,
              onAccountChanged: (account) =>
                  _onAccountChanged(context, account),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                var dateRange = await showDateRangePickerDialog(
                    context: context,
                    builder: (context, onDateRangeChanged) {
                      return BeanyDateRangePicker(
                        dateRange: DateRange(startDate, endDate),
                        onDateRangeChanged: onDateRangeChanged,
                      );
                    });
                if (!mounted) return;
                _onDateRangeChanged(context, dateRange);
              },
              child: const Text("Configure Date Range"),
            ),
            const SizedBox(height: 24),
            BalancePieChart(
              balance: widget.state.accountBalanceNode,
              onAccountSelected: (account) =>
                  _onAccountChanged(context, account),
            ),
          ],
        ),
      ),
    );
  }

  void _onAccountChanged(BuildContext context, Account account) {
    var bloc = BlocProvider.of<StatsScreenBloc>(context);
    bloc.add(StatsScreenStarted(
      account,
      widget.state.startDate,
      widget.state.endDate,
    ));
  }

  void _onDateRangeChanged(BuildContext context, DateRange? newDateRange) {
    if (newDateRange == null) return;

    var bloc = BlocProvider.of<StatsScreenBloc>(context);
    bloc.add(StatsScreenStarted(
      widget.state.accountBalanceNode.account,
      Date.truncate(newDateRange.start),
      Date.truncate(newDateRange.end),
    ));
  }
}

class BalancePieChart extends StatefulWidget {
  final AccountBalanceNode balance;
  final void Function(Account) onAccountSelected;

  const BalancePieChart({
    super.key,
    required this.balance,
    required this.onAccountSelected,
  });

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

                if (widget.balance.children.isEmpty) return;
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
    var totalEur = widget.balance.totalValue.val(CUR("EUR"));
    if (totalEur == null) return const [];

    final colors = _getColors(widget.balance.children.length);

    var dataList = <PieChartSectionData>[];
    for (var i = 0; i < widget.balance.children.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 220.0 : 200.0;

      var bal = widget.balance.children[i];
      var value = bal.totalValue.val(CUR("EUR"))!;

      var data = PieChartSectionData(
        color: colors[i % colors.length],
        value: (value / totalEur).toDouble() * 100,
        title: bal.account.parts().last,

        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
        badgeWidget: Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
    if (dataList.isEmpty) {
      final isTouched = 0 == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 220.0 : 200.0;

      var bal = widget.balance;
      var value = bal.totalValue.val(CUR("EUR"))!;

      var data = PieChartSectionData(
        color: colors[0 % colors.length],
        value: (value / totalEur).toDouble() * 100,
        title: bal.account.parts().last,

        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          // shadows: shadows,
        ),
        badgeWidget: Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            // shadows: shadows,
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

List<Color> _getColors(int num) {
  switch (num) {
    case 1:
      return [const Color(0xff003f5c)];
    case 2:
      return [const Color(0xff003f5c), const Color(0xffbc5090)];
    case 3:
      return [
        const Color(0xff003f5c),
        const Color(0xffbc5090),
        const Color(0xffffa600),
      ];
    case 4:
      return [
        const Color(0xff1D3140),
        const Color(0xff125862),
        const Color(0xff0B8174),
        const Color(0xff46AA75)
      ];
    case 5:
      return [
        const Color(0xff1D3140),
        const Color(0xff125862),
        const Color(0xff0B8174),
        const Color(0xff46AA75),
        const Color(0xff91D069)
      ];
    case 6:
      return [
        const Color(0xff1D3140),
        const Color(0xff125862),
        const Color(0xff0B8174),
        const Color(0xff46AA75),
        const Color(0xff91D069),
        const Color(0xffEDEF5D)
      ];
    default:
      return [
        const Color(0xff1D3140),
        const Color(0xff125862),
        const Color(0xff0B8174),
        const Color(0xff46AA75),
        const Color(0xff91D069),
        const Color(0xffEDEF5D)
      ];
  }
}
