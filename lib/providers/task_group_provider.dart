import 'package:flutter/foundation.dart';

import '../models/task.dart';
import '../models/task_group.dart';
import '../repositories/task_group_repository.dart';

class TaskGroupProvider extends ChangeNotifier {
  final TaskGroupRepository taskGroupRepo;
  TaskGroupProvider({this.taskGroupRepo}) {
    _isBreak = false;
  }
  List<TaskGroup> _groups;

  List<TaskGroup> get taskGroups => _groups;

  /// the current taskgroup the user has clicked or selected
  TaskGroup _current;

  TaskGroup get currentTaskGroup => _current;

  /// returns the number of completed tasks which will be used to calculate
  /// the position of breakTime and determine if it will be a `shortBreak` or
  /// a `longBreak`
  int get taskBreak => _current?.completedCount ?? 0;

  bool _isBreak;

  /// is `true` when a Break task is running and
  /// `false` when a user task is running
  bool get isBreak => _isBreak;

  /// [isBreak] must be checked first before using this function
  /// is `true` if a long break is next
  /// is `false` if a short break is next
  bool get isLongBreak =>
      (_current.completedCount % _current.longBreakIntervals) == 0;

  /// changes the [isBreak] value to either true or false and must be called
  /// whenever a task is finished and a break timer is to be created
  void toggleBreak() {
    _isBreak = !_isBreak;
    notifyListeners();
  }

  /// Called when app is opened
  Future<void> loadTaskGroups() async {
    try {
      _groups = await taskGroupRepo.fetchTaskGroups();
    } catch (e) {
      _groups = [];
    }
  }

  void deleteTaskGroup(String id) {
    _groups.removeWhere((taskGroup) => taskGroup.taskGroupId == id);
    notifyListeners();
    taskGroupRepo.updateTaskGroups(_groups);
  }

  void addTaskGroup(TaskGroup taskGroup) {
    _groups.add(taskGroup);
    notifyListeners();
    taskGroupRepo.updateTaskGroups(_groups);
  }

  void setCurrentTaskGroup(TaskGroup taskGroup) {
    _current = taskGroup;
    notifyListeners();
  }

  void updateTaskTime(Task task, Duration newTime) {
    task.timeRemaining = newTime;
    taskGroupRepo.updateTaskGroups(_groups);
    notifyListeners();
  }

  /// adds [bonusTime] from tasks finished earlier than the calculated
  /// deadline.\
  /// reset => true when we want to use the bonus for a task to create a clean
  /// slate.
  void updateBonusTime({Duration duration, bool reset = false}) {
    if (reset)
      _current.bonusTime = Duration.zero;
    else
      _current.bonusTime += duration;
    notifyListeners();
    taskGroupRepo.updateTaskGroups(_groups);
  }
}
