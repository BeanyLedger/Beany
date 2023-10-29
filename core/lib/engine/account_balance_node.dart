import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_balance_node.g.dart';

@JsonSerializable()
class AccountBalanceNode implements Equatable {
  final Account account;

  final Inventory cumulative;
  final Inventory ownValue;

  Inventory get totalValue => cumulative + ownValue;

  final List<AccountBalanceNode> children;

  AccountBalanceNode(
    this.account, {
    required this.ownValue,
    required this.cumulative,
    required this.children,
  });

  AccountBalanceNode? find(Account ac) {
    if (account == ac) return this;
    for (var child in children) {
      var found = child.find(ac);
      if (found != null) return found;
    }
    return null;
  }

  @override
  List<Object?> get props => [account, cumulative, ownValue, children];

  @override
  bool? get stringify => true;

  factory AccountBalanceNode.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceNodeFromJson(json);
  Map<String, dynamic> toJson() => _$AccountBalanceNodeToJson(this);
}
