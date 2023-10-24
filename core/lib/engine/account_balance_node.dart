import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_balance_node.g.dart';

@JsonSerializable()
class AccountBalanceNode implements Equatable {
  final Account account;

  final Map<String, Decimal> cumulative;
  final Map<String, Decimal> ownValue;

  Map<String, Decimal> get totalValue {
    var total = Map<String, Decimal>.from(cumulative);
    for (var currency in ownValue.keys) {
      total[currency] = (total[currency] ?? Decimal.zero) + ownValue[currency]!;
    }
    return total;
  }

  final List<AccountBalanceNode> children;

  AccountBalanceNode(
    this.account, {
    required this.ownValue,
    required this.cumulative,
    required this.children,
  });

  @override
  List<Object?> get props => [account, cumulative, ownValue, children];

  @override
  bool? get stringify => true;

  factory AccountBalanceNode.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceNodeFromJson(json);
  Map<String, dynamic> toJson() => _$AccountBalanceNodeToJson(this);

  static Map<String, Decimal> buildValue(Iterable<Amount> amounts) {
    return Map<String, Decimal>.fromIterables(
      amounts.map((a) => a.currency),
      amounts.map((a) => a.number),
    );
  }
}
