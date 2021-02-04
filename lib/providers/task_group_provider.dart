import 'package:flutter/foundation.dart';
import 'package:task_meter/models/task.dart';

import '../models/task_group.dart';

class TaskGroupProvider extends ChangeNotifier {
  // final TaskGroupRepository taskGroupRepo;
  TaskGroupProvider() {
    _loadTaskGroups();
    _isBreak = false;
  }
  //: _localStorage = localStorage;
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

  bool get isBreak => _isBreak;

  /// changes the [isBreak] value to either true or false and must be called
  /// whenever a task is finished and a break timer is to be created
  void toggleBreak() {
    _isBreak = !_isBreak;
    notifyListeners();
  }

  /// Called when app is opened
  Future<void> _loadTaskGroups() async {
    //TODO: load taskGroups from local storage / remote storage for web
    _groups = [];
  }

  void deleteTaskGroup(String id) {
    _groups.removeWhere((taskGroup) => taskGroup.taskGroupId == id);
    notifyListeners();
    //TODO: update database asynchronously
  }

  void addTaskGroup(TaskGroup taskGroup) {
    _groups.add(taskGroup);
    //TODO: update database asynchronously
    notifyListeners();
  }

  void setCurrentTaskGroup(TaskGroup taskGroup) {
    _current = taskGroup;
    notifyListeners();
  }

  void updateTaskTime(Task task, Duration newTime) {
    task.timeRemaining = newTime;
    notifyListeners();
  }

  void updateBonusTime({Duration duration, bool reset = false}) {
    if (reset)
      _current.bonusTime = Duration.zero;
    else
      _current.bonusTime += duration;
    notifyListeners();
  }
}
