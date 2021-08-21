// Mocks generated by Mockito 5.0.14 from annotations
// in task_meter/test/presentation/bloc/timer_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:task_meter/data/repositories/timer_repository.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [TimerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class TimerRepositoryMock extends _i1.Mock implements _i2.TimerRepository {
  TimerRepositoryMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<Duration> timerTicker(Duration? time) =>
      (super.noSuchMethod(Invocation.method(#timerTicker, [time]),
          returnValue: Stream<Duration>.empty()) as _i3.Stream<Duration>);
  @override
  String toString() => super.toString();
}
