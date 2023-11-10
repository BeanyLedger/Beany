import 'package:beany/src/expenses_screen.dart';
import 'package:beany/src/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';

class BeanyBottomBar extends StatelessWidget {
  const BeanyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Assets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_heart),
          label: 'Cash',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Transactions',
        ),
      ],
      currentIndex: 1,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      // selectedItemColor: Colors.amber[800],
      onTap: (i) {
        switch (i) {
          case 0:
          case 1:
          case 2:
            return;

          case 3:
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, ExpensesScreen.routeName);
            return;

          case 4:
            Navigator.pop(context);
            Navigator.pushNamed(context, SampleItemListView.routeName);
            return;
        }
      },
    );
  }
}
