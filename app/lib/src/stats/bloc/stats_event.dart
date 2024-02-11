import 'package:beany_core/core/account.dart';
import 'package:beany_core/misc/date.dart';
import 'package:equatable/equatable.dart';

sealed class StatsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class StatsScreenStarted extends StatsScreenEvent {
  final Account account;
  final Date startDate;
  final Date endDate;

  StatsScreenStarted(this.account, this.startDate, this.endDate);
}
