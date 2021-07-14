import 'dart:math';

import '../../domain/models/task.dart';
import '../../domain/models/task_group.dart';
import '../errors.dart';
import '../utils/task_utils.dart';

class TimeDivider {
  ///This function throws [TaskTimerException] with an error description
  ///string and must be caught in the UI to display to the user
  static void divideTimeByTask(TaskGroup taskGroup) {
    int difficultyCount = 0;
    // minimum difficulty in the list of tasks
    int minDiff = 3;

    // check if tasks is empty
    // if empty make the taskgroup title a single task
    if (taskGroup.tasks.isEmpty) {
      taskGroup.tasks.add(Task(
        difficulty: Difficulty.Medium,
        taskName: taskGroup.taskGroupName,
        timeRemaining: taskGroup.totalTime,
        totalTime: taskGroup.totalTime,
      ));
      // throw TaskTimerException(Error.EmptyTaskGroup);
    } else {
      //we increment the difficultyCount by the difficulty type of each tasks
      for (var task in taskGroup.tasks) {
        if (task.difficulty == Difficulty.Easy) {
          difficultyCount++;
          minDiff = 1;
        } else if (task.difficulty == Difficulty.Medium) {
          difficultyCount += 2;
          minDiff = min(minDiff, 2);
        } else
          difficultyCount += 3;
      }

      //calculate longBreaks in this group depending on the longBreakIntervals between tasks
      int longBreakCount = 0;
      if (taskGroup.longBreakIntervals < taskGroup.tasks.length) {
        longBreakCount =
            (taskGroup.tasks.length ~/ taskGroup.longBreakIntervals);
      }

      //calculate how much shortBreaks in this taskGroup
      int shortBreakCount = taskGroup.tasks.length - longBreakCount - 1;

      //the minimum time unit for task's time
      double unitTimeInMinutes = ((taskGroup.totalTime.inMinutes) -
              ((taskGroup.longBreakTime.inMinutes * longBreakCount) +
                  (taskGroup.shortBreakTime.inMinutes * shortBreakCount))) /
          difficultyCount;
      //! must be caught to display error **VALIDATING PART OF THE FUNCTION**
      TaskUtils.validateUnitTime(unitTimeInMinutes * minDiff, taskGroup);

      for (Task task in taskGroup.tasks) {
        _setTimeForTask(task, unitTimeInMinutes);
      }
    }
  }

  static void _setTimeForTask(Task task, double timeInMinutes) {
    int multiplier = 1;
    if (task.difficulty == Difficulty.Medium)
      multiplier = 2;
    else if (task.difficulty == Difficulty.Hard) multiplier = 3;

    timeInMinutes = timeInMinutes * multiplier;

    //setting the time for this task
    task.setTotalTime(new Duration(seconds: (timeInMinutes * 60).toInt()));
  }
}
