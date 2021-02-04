import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/timer_repository.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  StreamSubscription<Duration> _tickerSubscription;
  TimerRepository timerRepository;
  TimerBloc({TimerRepository timerRepo})
      : timerRepository = timerRepo,
        super(TimerReady(Duration.zero));
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStartEvent) {
      yield* _mapTimerStartEventToState(event);
    } else if (event is TimerTickEvent) {
      yield* _mapTimerTickEventToState(event);
    } else if (event is TimerPauseEvent) {
      yield* _mapTimerPauseEventToState(event);
    } else if (event is TimerResumeEvent) {
      yield* _mapTimerResumeEventToState();
    } else if (event is TimerFinishEvent) {
      yield* _mapTimerFinishEventToState(event);
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
        ? TimerFinished(Duration.zero) //TODO: add to database
        : TimerRunning(event.duration);
  }

  Stream<TimerState> _mapTimerPauseEventToState(TimerPauseEvent event) async* {
    //! Pause is only possible if timer is running.. hence `state` has to be `TimerRunning`
    if (state is TimerRunning) {
      _tickerSubscription?.pause();
      yield TimerPaused(state.duration);

      //TODO: save to local Database
    }
  }

  Stream<TimerState> _mapTimerResumeEventToState() async* {
    //! Timer can only resume if it was paused
    if (state is TimerPaused) {
      _tickerSubscription?.resume();
      yield TimerRunning(state.duration);
    }
  }

  Stream<TimerState> _mapTimerFinishEventToState(
      TimerFinishEvent event) async* {
    yield TimerFinished(state.duration);
    _tickerSubscription?.cancel();
    //TODO: add residual time to bonus time and save to database
  }
}
