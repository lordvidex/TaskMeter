part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final Duration _duration;
  const TimerState(this._duration);

  @override
  List<Object> get props => [_duration];
}

class TimerReady extends TimerState {
  final Duration _duration;
  TimerReady(this._duration) : super(_duration);
}

class TimerRunning extends TimerState {
  final Duration _duration;
  TimerRunning(this._duration) : super(_duration);
}

class TimerPaused extends TimerState {
  final Duration _duration;
  TimerPaused(this._duration) : super(_duration);
}

class TimerFinished extends TimerState {
  final Duration _duration;
  TimerFinished([this._duration]) : super(_duration ?? Duration.zero);
}
