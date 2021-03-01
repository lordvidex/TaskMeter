import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/errors.dart';
import 'package:task_meter/domain/models/task.dart';
import 'package:task_meter/domain/models/task_group.dart';
import 'package:task_meter/core/algorithms/time_divider.dart';

void main() {
  TaskGroup taskGroup1 = TaskGroup("math");
  TaskGroup taskGroup2 = TaskGroup("language");

  test("normal tasksGroup1", () {
    taskGroup1.shortBreakTime = Duration(minutes: 5);
    taskGroup1.longBreakTime = Duration(minutes: 10);
    taskGroup1.longBreakIntervals = 3;
    taskGroup1.totalTime = (Duration(hours: 1, minutes: 40));
    for (int i = 0; i < 5; i++) {
      taskGroup1.tasks.add(Task(taskName: 'Task $i'
          //difficulty: (i % 2 == 0) ? Difficulty.Hard : Difficulty.Medium
          ));
    }
    TimeDivider.divideTimeByTask(taskGroup1);
    expect(taskGroup1.tasks[1].totalTime, equals(Duration(minutes: 15)));
  });

  test("normal tasksGroup2", () {
    taskGroup2.shortBreakTime = Duration(minutes: 5);
    taskGroup2.longBreakTime = Duration(minutes: 10);
    taskGroup2.longBreakIntervals = 4;
    taskGroup2.totalTime = Duration(hours: 3);
    for (int i = 0; i < 10; i++) {
      taskGroup2.tasks.add(Task(
        taskName: 'Task $i',
        //difficulty: (i % 2 == 0) ? Difficulty.Hard : Difficulty.Medium
      ));
    }
    TimeDivider.divideTimeByTask(taskGroup2);
    expect(taskGroup2.tasks[1].totalTime,
        equals(Duration(minutes: 12, seconds: 30)));
  });
  test(
      'should throw TaskTimerException when break is short break is larger than long break',
      () {
    // arrange
    final longBreakDuration = Duration(minutes: 1);
    final shortBreakDuration = Duration(minutes: 4);
    taskGroup1 = TaskGroup('new task group',
        longBreakTime: longBreakDuration,
        shortBreakTime: shortBreakDuration,
        longBreakIntervals: 2);
    // act
    taskGroup1.totalTime = Duration(hours: 1);

    // assert
    expect(() => TimeDivider.divideTimeByTask(taskGroup1),
        throwsA(isA<TaskTimerException>()));
  });
  test(
      'should throw TaskTimerException when the smallest task time is less than the max break',
      () {
    // arrange
    final longBreakDuration = Duration(minutes: 15);
    final shortBreakDuration = Duration(minutes: 5);
    final List<Task> tasks = [Task(), Task(), Task()];
    taskGroup1 = TaskGroup('new task group',
        longBreakTime: longBreakDuration,
        shortBreakTime: shortBreakDuration,
        longBreakIntervals: 2);
    // act
    taskGroup1.totalTime = Duration(hours: 1);
    taskGroup1.tasks = tasks;

    // assert
    expect(() => TimeDivider.divideTimeByTask(taskGroup1),
        throwsA(isA<TaskTimerException>()));
  });
}
