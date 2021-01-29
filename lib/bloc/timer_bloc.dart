import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_meter/repositories/timer_repository.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  StreamSubscription<Duration> _tickerSubscription;
  TimerRepository timerRepository;
  TimerBloc({TimerRepository timerRepo})
      : timerRepository = timerRepo,
        super(TimerReady(Duration.zero));

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStartEvent) {
      yield* _mapTimerStartEventToState(event);
    } else if (event is TimerTickEvent) {
      yield* _mapTimerTickEventToState(event);
    }
  }

  // Helper Asynchronous generators
  Stream<TimerState> _mapTimerStartEventToState(TimerStartEvent event) async* {
    yield TimerReady(event.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = timerRepository
        .timerTicker(event.duration)
        .listen((newDuration) => add(TimerTickEvent(newDuration)));
  }

  Stream<TimerState> _mapTimerTickEventToState(TimerTickEvent event) async* {
    yield event.duration == Duration.zero
        ? TimerFinished()
        : TimerRunning(event.duration);
  }
}
