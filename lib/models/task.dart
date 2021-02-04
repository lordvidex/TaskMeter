import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Difficulty { Easy, Medium, Hard }

class Task extends Equatable {
  // auto generated taskId
  final String taskId;
  // name of task
  final String taskName;
  // difficulty of task [Easy, Medium, Hard]
  final Difficulty difficulty;
  // calculated duration of task
  //! Must call `setTotalTime` to properly instantiate time
  Duration _totalTime;

  //TODO: compute timeRemaining when user has started the task
  Duration timeRemaining;

  Task(
      {this.taskName = 'Default TaskName', this.difficulty = Difficulty.Medium})
      : this.taskId = Uuid().v1();

  // returns the totalTime calculated by the algorithm
  Duration get totalTime => _totalTime;

  /// returns true if some time has been used in this task
  bool get hasStarted => _totalTime != timeRemaining;

  ///@returns - a double value indicating the progress of the task where
  /// `0` - task not started
  /// `1` - task finished
  double get taskProgress {
    if (_totalTime == null || timeRemaining == null) {
      return 0;
    }
    print('taskProgress: ${timeRemaining.inMilliseconds}');
    return (_totalTime.inMilliseconds - timeRemaining.inMilliseconds) /
        _totalTime.inMilliseconds;
  }

  /// sets [totalTime] and timeRemaining to given `totalTime`
  void setTotalTime(Duration totalTime) {
    this._totalTime = totalTime;
    this.timeRemaining = totalTime;
  }

  bool get isCompleted => timeRemaining == Duration.zero;

  @override
  List<Object> get props => [taskId];
}
