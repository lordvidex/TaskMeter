import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/algorithms/duration_to_string.dart';

void main() {
  test("Time test in hours", () {
    expect(printDuration(new Duration(hours: 60)), "60:00:00");
  });
  test("Time test in minutes", () {
    expect(printDuration(new Duration(minutes: 100)), "01:40:00");
  });
  test("Time test in seconds", () {
    expect(printDuration(new Duration(seconds: 400)), "00:06:40");
  });
  test("Time test in hours and minutes", () {
    expect(printDuration(new Duration(hours: 5, minutes: 100)), "06:40:00");
  });
  test("Time test in minutes and seconds", () {
    expect(printDuration(new Duration(minutes: 50, seconds: 3600)), "01:50:00");
  });
}
