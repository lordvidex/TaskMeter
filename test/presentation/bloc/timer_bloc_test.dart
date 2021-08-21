import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/presentation/bloc/timer_bloc.dart';
import 'package:task_meter/data/repositories/timer_repository.dart';

import 'timer_bloc_test.mocks.dart';

@GenerateMocks([],
    customMocks: [MockSpec<TimerRepository>(as: #TimerRepositoryMock)])
void main() {
  late TimerRepositoryMock timerMock;
  late TimerBloc timerBloc;
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
      when(timerMock.timerTicker(any))
          .thenAnswer((_) => Stream.fromIterable([Duration(seconds: 1)]));
      // act
      timerBloc.add(TimerStartEvent(Duration(seconds: 3)));
      await untilCalled(timerMock.timerTicker(any));
      // assert
      verify(timerMock.timerTicker(Duration(seconds: 3)));
    });
    blocTest(
        'should return [TimerReady,TimerRunning] when TimerStartEvent is called',
        build: () {
          return timerBloc;
        },
        act: (dynamic bloc) {
          when(timerMock.timerTicker(any)).thenAnswer((_) =>
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
          when(timerMock.timerTicker(any)).thenAnswer((_) =>
              Stream.fromIterable([
                Duration(seconds: 2),
                Duration(seconds: 1),
                Duration(seconds: 0)
              ]));
          return timerBloc;
        },
        act: (dynamic bloc) {
          bloc.add(TimerPauseEvent());
        },
        expect: () => []);

    blocTest(
        'should return an [] state when TimerResumeEvent is called without a Paused state ',
        build: () {
          when(timerMock.timerTicker(any)).thenAnswer((_) =>
              Stream.fromIterable([
                Duration(seconds: 2),
                Duration(seconds: 1),
                Duration(seconds: 0)
              ]));
          return timerBloc;
        },
        act: (dynamic bloc) {
          bloc.add(TimerResumeEvent());
        },
        expect: () => []);
  });
}
