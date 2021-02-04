import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_meter/models/task_group.dart';

import '../models/settings.dart';

const String SETTINGS = 'settings';
const String TASKGROUPS = 'task_groups';

abstract class LocalStorage {
  //! Settings section
  /// Fetches the saved settings from the Database
  /// Returns `default` values for settings if user does not have saved data
  Future<Settings> fetchSettings();

  /// Update settings in the local database
  Future<void> updateSettings(Settings newSettings);

  /// fetches the List of taskGroups from the database
  Future<List<TaskGroup>> fetchTaskGroups();

  /// updates taskGroups in the database
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups);
}

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences sharedPreferences;
  LocalStorageImpl(this.sharedPreferences);

  @override
  Future<Settings> fetchSettings() async {
    if (sharedPreferences.containsKey(SETTINGS)) {
      //return the settings
      return Settings.fromJson(
          json.decode(sharedPreferences.getString(SETTINGS)));
    } else {
      // return the default settings and save it to the database
      await sharedPreferences.setString(
          SETTINGS, json.encode(Settings.defaultSettings().toJson()));
      return Settings.defaultSettings();
    }
  }

  @override
  Future<void> updateSettings(Settings newSettings) async {
    await sharedPreferences.setString(
        SETTINGS, json.encode(newSettings.toJson()));
  }

  @override
  Future<List<TaskGroup>> fetchTaskGroups() async {
    if (sharedPreferences.containsKey(TASKGROUPS)) {
      return sharedPreferences
          .getStringList(TASKGROUPS)
          .map((tg) => TaskGroup.fromJson(json.decode(tg)))
          .toList();
    } else {
      //! the local storage is either empty or there was an error
      return [];
    }
  }

  @override
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups) async {
    return await sharedPreferences.setStringList(
        TASKGROUPS, taskGroups.map((tg) => json.encode(tg.toJson())).toList());
  }
}
