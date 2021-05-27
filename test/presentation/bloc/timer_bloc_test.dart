import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_meter/presentation/bloc/timer_bloc.dart';
import 'package:task_meter/data/repositories/timer_repository.dart';

class TimerRepositoryMock extends Mock implements TimerRepository {}

class FakeDuration extends Fake implements Duration {}

void main() {
  TimerRepositoryMock timerMock;
  TimerBloc timerBloc;
  setUpAll(() {
    registerFallbackValue<Duration>(FakeDuration());
  });
  setUp(() {
    timerMock = TimerRepositoryMock();
    timerBloc = TimerBloc(timerRepo: timerMock);
  });
  group('Timer Bloc', () {
    blocTest('should return an empty state when created ',
        build: () => TimerBloc(), expect: () => []);
    test(
        'should call the timerTicker function on the Timer class when startEvent is created',
        () async {
      // arrange
      when(() => timerMock.timerTicker(any()))
          .thenAnswer((_) => Stream.fromIterable([Duration(seconds: 1)]));
      // act
      timerBloc.add(TimerStartEvent(Duration(seconds: 3)));
      await untilCalled(() => timerMock.timerTicker(any()));
      // assert
      verify(() => timerMock.timerTicker(Duration(seconds: 3)));
    });
    blocTest(
        'should return [TimerReady,TimerRunning] when TimerStartEvent is called',
        build: () {
          return timerBloc;
        },
        act: (bloc) {
          when(() => timerMock.timerTicker(any())).thenAnswer((_) =>
              Stream.fromIterable([
                Duration(seconds: 2),
                Duration(seconds: 1),
                Duration(seconds: 0)
              ]));
          bloc.add(TimerStartEvent(Duration(seconds: 3)));
        },
        expect: () => [
              TimerReady(Duration(seconds: 3)),
              TimerRunning(Duration(seconds: 2)),
              TimerRunning(Duration(seconds: 1)),
              TimerFinished(Duration.zero)
            ]);
    blocTest(
        'should return no state if a PauseEvent is registered and timer is not running',
        build: () {
          when(() => timerMock.timerTicker(any())).thenAnswer((_) =>
              Stream.fromIterable([
                Duration(seconds: 2),
                Duration(seconds: 1),
                Duration(seconds: 0)
              ]));
          return timerBloc;
        },
        act: (bloc) {
          bloc.add(TimerPauseEvent());
        },
        expect: () => []);

    blocTest(
        'should return an [] state when TimerResumeEvent is called without a Paused state ',
        build: () {
          when(() => timerMock.timerTicker(any())).thenAnswer((_) =>
              Stream.fromIterable([
                Duration(seconds: 2),
                Duration(seconds: 1),
                Duration(seconds: 0)
              ]));
          return timerBloc;
        },
        act: (bloc) {
          bloc.add(TimerResumeEvent());
        },
        expect: () => []);
    //! Mocking timer isn't feasible for the pause test.. we use the real implementation
    // blocTest(
    //     'should return a TimerPaused state when a TimerPauseEvent is sent while Timer is running',
    //     build: () {
    //   return TimerBloc(timerRepo: TimerRepository());
    // }, act: (bloc) async {
    //   bloc.add(TimerStartEvent(Duration(seconds: 3)));
    //   await Future.delayed(Duration(seconds: 2));
    //   bloc.add(TimerPauseEvent());
    // }, expect: [
    //   TimerReady(Duration(seconds: 3)),
    //   TimerRunning(Duration(seconds: 2)),
    //   TimerPaused(Duration(seconds: 2))
    // ]);

    // blocTest(
    //     'should return [TimerReady, TimerRunning, TimerPaused, TimerRunning, TimerFinished] to test resume Event ',
    //     build: () {
    //   return TimerBloc(timerRepo: TimerRepository())
    //     ..add(TimerStartEvent(Duration(seconds: 4)));
    // }, act: (bloc) async {
    //   await Future.delayed(Duration(seconds: 2));
    //   bloc.add(TimerPauseEvent());
    //   await Future.delayed(Duration(seconds: 2));
    //   bloc.add(TimerResumeEvent());
    // }, expect: [
    //   TimerReady(Duration(seconds: 4)),
    //   TimerRunning(Duration(seconds: 3)),
    //   TimerPaused(Duration(seconds: 3)),
    //   TimerRunning(Duration(seconds: 2)),
    //   //TimerRunning(Duration(seconds: 1)),
    //   TimerFinished()
    // ], wait: Duration(seconds: 8));
  });
}
