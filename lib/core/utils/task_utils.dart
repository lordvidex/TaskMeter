import '../../domain/models/task_group.dart';
import '../errors.dart';

class TaskUtils {
  static validateUnitTime(double unitTaskTimeInMinutes, TaskGroup taskGroup) {
    if (taskGroup.longBreakTime < taskGroup.shortBreakTime) {
      throw TaskTimerException(Error.LongBreakLessThanShortBreak);
    } else if (unitTaskTimeInMinutes < taskGroup.longBreakTime.inMinutes) {
      throw TaskTimerException(Error.TaskUnitTimeLessThanBreak);
    }
  }
}
