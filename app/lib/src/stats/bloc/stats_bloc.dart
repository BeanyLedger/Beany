import 'package:bloc/bloc.dart';

import 'stats_event.dart';
import 'stats_state.dart';

import 'package:beany_backend/beany_backend.dart' as bb;

class StatsScreenBloc extends Bloc<StatsScreenEvent, StatsScreenState> {
  final bb.BeanyHttpClient client;

  // FIXME: We need a proper repo class over here!!
  //        But I'm not sure how to model that!
  StatsScreenBloc()
      : client = bb.BeanyHttpClient('http://127.0.0.1:8080'),
        super(const StatsScreenLoading()) {
    on<StatsScreenStarted>(_onStatsScreenStarted);
  }

  Future<void> _onStatsScreenStarted(
    StatsScreenStarted event,
    Emitter<StatsScreenState> emit,
  ) async {
    emit(const StatsScreenLoading());

    try {
      final node = await client.balance(
        event.account,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(StatsScreenLoaded(node, event.startDate, event.endDate));
    } catch (e) {
      emit(StatsScreenError(e.toString()));
    }
  }
}
