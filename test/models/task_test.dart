import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/models/task.dart';

void main() {
  Task task1;
  Task task2;

  setUp(() {
    task1 = Task();
    task2 = Task(taskName: 'Finish my Homework');
  });
  test('should return `Default TaskName` when taskName is not specified', () {
    String defaultName = 'Default TaskName';
    expect(task1.taskName, defaultName);
  });

  test(
      'should return `null` values for tasktimes when time has not been calculated',
      () {
    // assert
    expect(task1.timeRemaining, null);
  });
  test('should return 0 for taskProgress when task times are null', () {
    expect(task1.taskProgress, equals(0));
  });
  test(
      'tasks should have equal totalTime and remainingTime when time is allocated for the task',
      () {
    // act
    task1.setTotalTime(Duration(seconds: 5));
    // assert
    expect(task1.totalTime, equals(task1.timeRemaining));
  });

  group('Two tasks with the same name', () {
    test('should not be equal', () {
      // arrange
      task1 = Task();
      task2 = Task();
      // assert
      assert (task1.taskName == task2.taskName);
      expect(task1 == task2, isFalse);
    });
  });
}
