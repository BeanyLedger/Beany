import 'package:beany_core/core/account.dart';
import 'package:equatable/equatable.dart';

import 'package:beany_backend/beany_backend.dart' as bb;

sealed class StatsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class StatsScreenStarted extends StatsScreenEvent {
  final Account account;
  final bb.DateRange dateRange;

  StatsScreenStarted(this.account, this.dateRange);
}
