import '../../domain/models/task_group.dart';
import '../datasources/local_storage.dart';

abstract class TaskGroupRepository {
  /// fetches taskGroups from either local storage or remote storage
  Future<List<TaskGroup>> fetchTaskGroups();

  /// updates taskGroups value to local and remote storage
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups);
}

class TaskGroupRepositoryImpl extends TaskGroupRepository {
  final LocalStorage _localStorage;
  TaskGroupRepositoryImpl(this._localStorage);
  @override
  Future<List<TaskGroup>> fetchTaskGroups() {
    return _localStorage.fetchTaskGroups();
  }

  @override
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups) {
    return _localStorage.updateTaskGroups(taskGroups);
  }
}
