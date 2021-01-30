import 'package:flutter/foundation.dart';

import '../models/task_group.dart';

class TaskGroupProvider extends ChangeNotifier {
  //final LocalStorage _localStorage;
  TaskGroupProvider() {
    _loadTaskGroups();
  }
  //: _localStorage = localStorage;
  List<TaskGroup> _groups;

  List<TaskGroup> get taskGroups => _groups;

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
}
