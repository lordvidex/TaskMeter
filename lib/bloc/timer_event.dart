part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStartEvent extends TimerEvent {
  final Duration duration;
  const TimerStartEvent(this.duration);
  @override
  List<Object> get props => [duration];
}

class TimerResumeEvent extends TimerEvent {}

class TimerPauseEvent extends TimerEvent {}

// called periodically every seconds to countdown timer
class TimerTickEvent extends TimerEvent {
  final Duration duration;
  TimerTickEvent(this.duration);
}

// called when the user finished before time expended
class TimerFinishEvent extends TimerEvent {}
