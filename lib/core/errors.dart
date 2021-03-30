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

/// Thrown when there is no access to Internet
class NetworkException implements Exception {}

/// Thrown when cache can't be read
class CacheException implements Exception {}

/// Thrown for server related errors {e.g. firebase}
class ServerException implements Exception {}

/// Thrown when a user tries to signup with an existing user data
class UserExistsException implements Exception {}

/// Thrown when signing in with wrong credentials
class UserDoesNotExistException implements Exception {}

/// Thrown when user logs in with wrong password
class WrongCredentialsException implements Exception {}
