import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:beany_core/engine/position.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:meta/meta.dart';

@immutable
class AccountInventoryMap extends Equatable {
  final IMap<Account, Inventory> map;

  AccountInventoryMap([Map<Account, Inventory>? m = null]) : map = IMap(m);

  @override
  List<Object?> get props => [map];

  Amount? amountBy(Account account, Currency currency) {
    return map[account]?.amountBy(currency);
  }

  int get length => map.length;
  Iterable<Account> get accounts => map.keys;

  AccountInventoryMap operator -(AccountInventoryMap other) {
    var diff = AccountInventoryMap();
    var allAccounts = Set<Account>.from([...accounts, ...other.accounts]);

    for (var account in allAccounts) {
      var myInv = map[account] ?? Inventory();
      var theirInv = other.map[account] ?? Inventory();

      var amountDiff = myInv - theirInv;
      if (amountDiff.isNotEmpty) {
        diff = diff.addInventory(account, amountDiff);
      }
    }

    return diff;
  }

  AccountInventoryMap add(Account account, Posting posting) {
    var pos = Position.fromPosting(posting);
    return addInventory(account, Inventory([pos]));
  }

  AccountInventoryMap addInventory(Account account, Inventory ma) {
    return AccountInventoryMap(
      {
        ...map.unlockView,
        account: (map[account] ?? Inventory()) + ma,
      },
    );
  }

  Inventory? val(Account account) => map[account];
  Inventory? operator [](Account account) => val(account);

  factory AccountInventoryMap.fromJson(Map<String, dynamic> json) {
    return AccountInventoryMap(json.map((key, value) {
      return MapEntry(Account(key), Inventory.fromJson(value));
    }));
  }
  Map<String, dynamic> toJson() => map.unlockView.map(
        (key, value) => new MapEntry(key.value, value.toJson()),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccountInventoryMap) return false;

    if (other.map.length != map.length) return false;
    for (var account in map.keys) {
      if (other.map[account] != map[account]) return false;
    }
    return true;
  }
}
