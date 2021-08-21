part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final Duration? duration;
  const TimerState(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerReady extends TimerState {
  final Duration? duration;
  TimerReady(this.duration) : super(duration);
}

class TimerRunning extends TimerState {
  final Duration? duration;
  TimerRunning(this.duration) : super(duration);
}

class TimerPaused extends TimerState {
  final Duration? duration;
  TimerPaused(this.duration) : super(duration);
}

class TimerFinished extends TimerState {
  final Duration? duration;
  TimerFinished([this.duration]) : super(duration ?? Duration.zero);
}
