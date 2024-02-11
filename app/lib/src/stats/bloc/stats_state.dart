import 'package:beany_core/engine/account_balance_node.dart';
import 'package:equatable/equatable.dart';

import 'package:beany_backend/beany_backend.dart' as bb;

sealed class StatsScreenState extends Equatable {
  const StatsScreenState();

  @override
  List<Object> get props => [];
}

final class StatsScreenLoading extends StatsScreenState {
  const StatsScreenLoading();

  @override
  List<Object> get props => [];
}

final class StatsScreenLoaded extends StatsScreenState {
  final AccountBalanceNode accountBalanceNode;
  final bb.DateRange dateRange;

  const StatsScreenLoaded(this.accountBalanceNode, this.dateRange);

  @override
  List<Object> get props => [accountBalanceNode, dateRange];
}

final class StatsScreenError extends StatsScreenState {
  final String message;

  const StatsScreenError(this.message);

  @override
  List<Object> get props => [message];
}
