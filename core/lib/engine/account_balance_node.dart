import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_balance_node.g.dart';

@JsonSerializable()
class AccountBalanceNode implements Equatable {
  final Account account;

  final MultiAmount cumulative;
  final MultiAmount ownValue;

  MultiAmount get totalValue => cumulative + ownValue;

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
}
