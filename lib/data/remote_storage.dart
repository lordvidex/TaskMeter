import 'package:task_meter/models/settings.dart';
import 'package:task_meter/models/task_group.dart';

abstract class RemoteStorage {
  //! Settings section
  /// Fetches the saved settings from Firebase
  /// Returns `null` if user does not have saved data
  Future<Settings> fetchSettings();

  /// Update settings in the remote database
  Future<void> updateSettings(Settings newSettings);

  /// fetches the List of taskGroups from firebase and returns `null` if user
  /// either not logged in or does not have any data saved
  Future<List<TaskGroup>> fetchTaskGroups();

  /// updates taskGroups in the database
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups);
}

class RemoteStorageImpl extends RemoteStorage {
  @override
  Future<Settings> fetchSettings() {
    // TODO: implement fetchSettings
    return null;
  }

  @override
  Future<List<TaskGroup>> fetchTaskGroups() {
    // TODO: implement fetchTaskGroups
    return null;
  }

  @override
  Future<void> updateSettings(Settings newSettings) {
    // TODO: implement updateSettings
  }

  @override
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups) {
    // TODO: implement updateTaskGroups
  }
}
