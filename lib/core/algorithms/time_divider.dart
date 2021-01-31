import '../../models/task.dart';
import '../../models/task_group.dart';

//divide the total time of the grouptask on each task depending on the difficulty
void divideTimeByTask(TaskGroup taskGroup) {
  int tasksDuration = 0;

  //we increment the tasksDuration by the difficulty type of each tasks
  for (var task in taskGroup.tasks) {
    if (task.difficulty == Difficulty.Easy)
      tasksDuration++;
    else if (task.difficulty == Difficulty.Medium)
      tasksDuration += 2;
    else
      tasksDuration += 3;
  }

  //calculate how much longBreaks do this group has depending of the intervals between each task
  int numberLongBreakTime = 0;
  if (taskGroup.intervals < taskGroup.tasks.length) {
    numberLongBreakTime = (taskGroup.tasks.length ~/ taskGroup.intervals);
  }

  //calculate how much shortBreaks do this group has depending of the intervals between each task
  int numberShortBreakTime = taskGroup.tasks.length - numberLongBreakTime - 1;

  //the minimum time unit for task's time
  double taskTimeInMinutes = ((taskGroup.totalTime.inMinutes) -
          ((taskGroup.longBreakTime.inMinutes * numberLongBreakTime) +
              (taskGroup.shortBreakTime.inMinutes * numberShortBreakTime))) /
      tasksDuration;

  for (Task task in taskGroup.tasks) {
    _setTimeForTask(task, taskTimeInMinutes);
  }
}

void _setTimeForTask(Task task, double timeInMinutes) {
  int additinalTimeCounts = 1;
  if (task.difficulty == Difficulty.Medium)
    additinalTimeCounts = 2;
  else if (task.difficulty == Difficulty.Hard) additinalTimeCounts = 3;

  timeInMinutes = timeInMinutes * additinalTimeCounts;

  //setting the time for this task
  task.setTotalTime(new Duration(
      minutes: timeInMinutes.toInt(),
      seconds: ((timeInMinutes - timeInMinutes.toInt()) * 60).toInt()
      /*,milliseconds:(((timeInMinutes - timeInMinutes.toInt()) * 60)-
      (timeInMinutes - timeInMinutes.toInt()) * 60).toInt()*/
      ));
}
