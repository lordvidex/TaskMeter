import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/utils/duration_utils.dart';

void main() {
  group('durationToReadableString', () {
    test('hours', () {
      expect(DurationUtils.durationToReadableString(Duration(hours: 20)),
          '20 Hours ');
    });
    test('minutes', () {
      expect(DurationUtils.durationToReadableString(Duration(minutes: 30)),
          '30 Minutes ');
    });
    test('seconds', () {
      expect(DurationUtils.durationToReadableString(Duration(seconds: 40)),
          '40 Seconds ');
    });
    test('hours and minutes', () {
      expect(
          DurationUtils.durationToReadableString(
              Duration(hours: 2, minutes: 70)),
          '3 Hours 10 Minutes ');
    });
    test('minutes and seconds', () {
      expect(
          DurationUtils.durationToReadableString(
              Duration(minutes: 50, seconds: 1200)),
          '1 Hour 10 Minutes ');
    });
    test('Non-plural case senstive ', () {
      expect(
          DurationUtils.durationToReadableString(
              Duration(hours: 1, minutes: 1, seconds: 1)),
          '1 Hour 1 Minute 1 Second ');
    });
  });
  group('durationToClockString', () {
    test("Time test in hours", () {
      expect(DurationUtils.durationToClockString(new Duration(hours: 60)),
          "60:00:00");
    });
    test("Time test in minutes", () {
      expect(DurationUtils.durationToClockString(new Duration(minutes: 100)),
          "01:40:00");
    });
    test("Time test in seconds", () {
      expect(DurationUtils.durationToClockString(new Duration(seconds: 400)),
          "00:06:40");
    });
    test("Time test in hours and minutes", () {
      expect(
          DurationUtils.durationToClockString(
              new Duration(hours: 5, minutes: 100)),
          "06:40:00");
    });
    test("Time test in minutes and seconds", () {
      expect(
          DurationUtils.durationToClockString(
              new Duration(minutes: 50, seconds: 3600)),
          "01:50:00");
    });
    test('Time test for long days', () {
      // arrange

      // act
      final answer = "8760:00:00";
      // assert
      expect(DurationUtils.durationToClockString(Duration(days: 365)),
          equals(answer));
    });
  });
}
