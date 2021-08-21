import '../../domain/models/task_group.dart';
import '../datasources/local_storage.dart';
import '../datasources/remote_storage.dart';

abstract class TaskGroupRepository {
  /// fetches taskGroups from either local storage or remote storage
  Future<List<TaskGroup>?> fetchTaskGroups();

  /// updates taskGroups value to local and remote storage
  Future<void> updateTaskGroups(List<TaskGroup>? taskGroups,
      {bool? delete, bool? add, String? id});
}

class TaskGroupRepositoryImpl extends TaskGroupRepository {
  final LocalStorage? _localStorage;
  final RemoteStorage? _remoteStorage;
  TaskGroupRepositoryImpl(
      {LocalStorage? localStorage, RemoteStorage? remoteStorage})
      : this._localStorage = localStorage,
        this._remoteStorage = remoteStorage;
  @override
  Future<List<TaskGroup>?> fetchTaskGroups() async {
    final remoteLastTime = await _remoteStorage!.getLastTaskGroupUpdateTime();
    final localLastTime = await _localStorage!.getLastTaskGroupUpdateTime();
    if (remoteLastTime == null || localLastTime!.compareTo(remoteLastTime) >= 0) {
      // work with only local data, return local and update remote
      final _localData = await _localStorage!.fetchTaskGroups();
      await _remoteStorage!.updateTaskGroups(_localData, localLastTime);
      return _localData;
    } else {
      // work with remoteData, update local and return remote
      final _remoteData = await _remoteStorage!.fetchTaskGroups();
      await _localStorage!.updateTaskGroups(_remoteData, remoteLastTime);
      return _remoteData;
    }
  }

  @override
  Future<void> updateTaskGroups(List<TaskGroup>? taskGroups,
      {bool? delete = false, bool? add = false, String? id}) async {
    DateTime now = DateTime.now();
    await _localStorage!.updateTaskGroups(taskGroups, now);
    if (delete!) {
      _remoteStorage!.deleteTaskGroup(id, now);
    } else if (add!) {
      _remoteStorage!.addTaskGroup(
          taskGroups!.firstWhere((t) => t.taskGroupId == id), now);
    } else {
      _remoteStorage!.updateTaskGroups(taskGroups, now);
    }
  }
}
