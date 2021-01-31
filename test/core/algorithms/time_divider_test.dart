import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/models/task.dart';
import 'package:task_meter/models/task_group.dart';
import 'package:task_meter/core/algorithms/time_divider.dart';

void main() {
  TaskGroup taskGroup1 = TaskGroup("math");
  TaskGroup taskGroup2 = TaskGroup("language");

  test("tasksGroup1", () {
    taskGroup1.shortBreakTime = Duration(minutes: 5);
    taskGroup1.longBreakTime = Duration(minutes: 10);
    taskGroup1.intervals = 3;
    taskGroup1.totalTime = (Duration(hours: 1, minutes: 40));
    for (int i = 0; i < 5; i++) {
      taskGroup1.tasks.add(Task(taskName: 'Task $i'
          //difficulty: (i % 2 == 0) ? Difficulty.Hard : Difficulty.Medium
          ));
    }
    divideTimeByTask(taskGroup1);
    expect(taskGroup1.tasks[1].totalTime, equals(Duration(minutes: 15)));
  });

  test("tasksGroup2", () {
    taskGroup2.shortBreakTime = Duration(minutes: 5);
    taskGroup2.longBreakTime = Duration(minutes: 10);
    taskGroup2.intervals = 4;
    taskGroup2.totalTime = Duration(hours: 3);
    for (int i = 0; i < 10; i++) {
      taskGroup2.tasks.add(Task(
        taskName: 'Task $i',
        //difficulty: (i % 2 == 0) ? Difficulty.Hard : Difficulty.Medium
      ));
    }
    divideTimeByTask(taskGroup2);
    expect(taskGroup2.tasks[1].totalTime,
        equals(Duration(minutes: 12, seconds: 30)));
  });
}
