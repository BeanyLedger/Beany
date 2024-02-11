import 'package:beany/src/assets/assets_screen.dart';
import 'package:beany/src/cash/cash_screen.dart';
import 'package:beany/src/stats/view/stats_screen.dart';
import 'package:beany/src/home/home_screen.dart';
import 'package:beany/src/ledger/ledger_screen.dart';
import 'package:flutter/material.dart';

class _BottomNavBarInfo {
  final String label;
  final Widget icon;
  final String route;

  _BottomNavBarInfo({
    required this.label,
    required this.icon,
    required this.route,
  });
}

final _bottomInfo = [
  _BottomNavBarInfo(
    label: 'Home',
    icon: const Icon(Icons.home),
    route: HomeScreen.routeName,
  ),
  _BottomNavBarInfo(
    label: 'Assets',
    icon: const Icon(Icons.business),
    route: AssetsScreen.routeName,
  ),
  _BottomNavBarInfo(
    label: 'Cash',
    icon: const Icon(Icons.monitor_heart),
    route: CashScreen.routeName,
  ),
  _BottomNavBarInfo(
    label: 'Stats',
    icon: const Icon(Icons.leaderboard),
    route: StatsScreen.routeName,
  ),
  _BottomNavBarInfo(
    label: 'Transactions',
    icon: const Icon(Icons.book),
    route: LedgerScreen.routeName,
  ),
];

class BeanyBottomBar extends StatelessWidget {
  const BeanyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    var routeName = ModalRoute.of(context)?.settings.name;
    var currentIndex = _bottomInfo.indexWhere((bi) => bi.route == routeName);
    if (currentIndex == -1) currentIndex = 0;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        for (var bi in _bottomInfo)
          BottomNavigationBarItem(icon: bi.icon, label: bi.label),
      ],
      currentIndex: currentIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      // selectedItemColor: Colors.amber[800],
      onTap: (i) {
        if (currentIndex == i) return;
        var info = _bottomInfo[i];

        // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, info.route);
      },
    );
  }
}
