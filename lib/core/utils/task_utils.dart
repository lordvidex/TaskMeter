import 'package:task_meter/core/errors.dart';
import 'package:task_meter/models/task_group.dart';

class TaskUtils {
  static validateUnitTime(double unitTaskTimeInMinutes, TaskGroup taskGroup) {
    if (taskGroup.longBreakTime < taskGroup.shortBreakTime) {
      throw TaskTimerException(Error.LongBreakLessThanShortBreak);
    } else if (unitTaskTimeInMinutes < taskGroup.longBreakTime.inMinutes) {
      throw TaskTimerException(Error.TaskUnitTimeLessThanBreak);
    }
  }
}
