class ErrorStrings {
  static String emptyTaskTimer = 'Task is Empty';
}

/// App related errors
enum Error {
  LongBreakLessThanShortBreak,
  TaskUnitTimeLessThanBreak,
  EmptyTaskGroup,
}

class TaskTimerException implements Exception {
  final Error _error;
  TaskTimerException(this._error);
  @override
  String toString() {
    if (_error == Error.LongBreakLessThanShortBreak) {
      return "Long Break Time must be greater than short break time";
    } else if (_error == Error.TaskUnitTimeLessThanBreak) {
      return "Smallest time must be greater than break times";
    } else if (_error == Error.EmptyTaskGroup) {
      return "Task Group must contain at least one task";
    }
    return super.toString();
  }
}
