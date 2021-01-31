import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/algorithms/duration_to_letters.dart';

void main() {
  test('hours', () {
    expect(durationInLetters(Duration(hours: 20)), '20 Hours ');
  });
  test('minutes', () {
    expect(durationInLetters(Duration(minutes: 30)), '30 Minutes ');
  });
  test('seconds', () {
    expect(durationInLetters(Duration(seconds: 40)), '40 Seconds ');
  });
  test('hours and minutes', () {
    expect(durationInLetters(Duration(hours: 2, minutes: 70)),
        '3 Hours 10 Minutes ');
  });
  test('minutes and seconds', () {
    expect(durationInLetters(Duration(minutes: 50, seconds: 1200)),
        '1 Hour 10 Minutes ');
  });
  test('Non-plural case senstive ', () {
    expect(durationInLetters(Duration(hours: 1, minutes: 1, seconds: 1)),
        '1 Hour 1 Minute 1 Second ');
  });
}
