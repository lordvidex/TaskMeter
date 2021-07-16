import 'package:flutter/foundation.dart';

import '../../domain/models/task.dart';
import '../../domain/models/task_group.dart';
import '../../data/repositories/task_group_repository.dart';

class TaskGroupProvider extends ChangeNotifier {
  final TaskGroupRepository taskGroupRepo;
  TaskGroupProvider({this.taskGroupRepo}) {
    _isBreak = false;
  }
  List<TaskGroup> _groups;

  List<TaskGroup> get taskGroups => _groups..removeWhere((t) => t.isDeleted);

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

    notifyListeners();
  }

  void deleteTaskGroup(String id) async {
    TaskGroup deletedTg = _groups.firstWhere((taskGroup) {
      return taskGroup.taskGroupId == id;
    });
    if (deletedTg != null) {
      deletedTg.isDeleted = true;
      await taskGroupRepo.updateTaskGroups(_groups, delete: true, id: id);
    }
    notifyListeners();
  }

  void addTaskGroup(TaskGroup taskGroup) async {
    _groups.add(taskGroup);
    await taskGroupRepo.updateTaskGroups(_groups,
        add: true, id: taskGroup.taskGroupId);
    notifyListeners();
  }

  void setCurrentTaskGroup(TaskGroup taskGroup) {
    _current = taskGroup;
    notifyListeners();
  }

  void updateTaskTime(Task task, Duration newTime) async {
    task.timeRemaining = newTime;
    await taskGroupRepo.updateTaskGroups(_groups);
    notifyListeners();
  }

  /// adds [bonusTime] from tasks finished earlier than the calculated
  /// deadline.\
  /// reset => true when we want to use the bonus for a task to create a clean
  /// slate.
  void updateBonusTime({Duration duration, bool reset = false}) async {
    if (reset)
      _current.bonusTime = Duration.zero;
    else
      _current.bonusTime += duration;

    await taskGroupRepo.updateTaskGroups(_groups);
    notifyListeners();
  }

  /// total tasks completed including deleted items
  int get tasksCompleted => _groups.fold<int>(
      0, (previous, element) => previous + element.completedCount);

  /// total tracked hours by this user
  double get trackedHours =>
      _groups.fold<double>(
          0.0, (previous, element) => previous + element.timeElapsed) /
      60;
}
