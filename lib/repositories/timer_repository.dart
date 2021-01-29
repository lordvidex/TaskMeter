class TimerRepository {
  ///@returns a `Duration` every second and reduces it's value
  ///by `1 second`
  Stream<Duration> timerTicker(Duration time) {
    return Stream.periodic(
            Duration(seconds: 1), (x) => time - Duration(seconds: 1))
        .take(time.inSeconds);
  }
}
