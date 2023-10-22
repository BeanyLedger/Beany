import 'package:beany/src/expenses_screen.dart';
import 'package:beany/src/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Ledger'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SampleItemListView.routeName);
            },
          ),
          ListTile(
            title: const Text('Expenses'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ExpensesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
