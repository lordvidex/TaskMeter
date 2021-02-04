import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/models/task.dart';
import 'package:uuid/uuid.dart';

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
      assert(task1.taskName == task2.taskName);
      expect(task1 == task2, isFalse);
    });
  });
  group('Conversion toJson', () {
    test('should successfully convert Task to json map', () {
      // arrange
      final String id = Uuid().v1();
      final String taskName = 'My Task';
      final Duration timeRem = Duration(seconds: 50);
      final Duration totalTime = Duration(minutes: 1);
      final expectedJson = {
        'task_id': id,
        'difficulty': 0,
        'task_name': taskName,
        'time_remaining': timeRem.inSeconds,
        'total_time': totalTime.inSeconds,
      };
      Task t1 = Task(
          taskId: id,
          difficulty: Difficulty.Easy,
          taskName: taskName,
          timeRemaining: timeRem,
          totalTime: totalTime);
      // act
      final jsonResult = t1.toJson();
      // assert
      expect(jsonResult, equals(expectedJson));
    });
    test('should return a json value even when timeRemaining/totalTime is null',
        () {
      // arrange
      final String id = Uuid().v1();
      final String taskName = 'My Task';
      final expectedJson = {
        'task_id': id,
        'difficulty': 0,
        'task_name': taskName,
        'time_remaining': null,
        'total_time': null,
      };
      Task t1 = Task(
        taskId: id,
        difficulty: Difficulty.Easy,
        taskName: taskName,
      );
      // act
      final jsonResult = t1.toJson();
      // assert
      expect(jsonResult, equals(expectedJson));
    });
  });
  group('Conversion fromJson', () {
    //! equals won't verify the equality of all the values
    //! since the taskId is used to uniquely verify the tasks
    test('should return expected Task', () {
      // arrange
      final String id = Uuid().v1();
      final String taskName = 'My Task';
      final json = {
        'task_id': id,
        'difficulty': 0,
        'task_name': taskName,
        'time_remaining': null,
        'total_time': null,
      };
      // act
      final task = Task.fromJson(json);
      // assert
      expect(task.taskName, equals(taskName));
      expect(task.taskId, equals(id));
      expect(task.difficulty, equals(Difficulty.Easy));
      expect(task.timeRemaining, isNull);
      expect(task.totalTime, isNull);
    });
  });
}
