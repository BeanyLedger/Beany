import 'package:beany_core/core/account.dart';
import 'package:flutter/material.dart';

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
