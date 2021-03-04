import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/settings.dart';
import '../../domain/models/task_group.dart';

const String SETTINGS = 'settings';
const String TASKGROUPS = 'task_groups';

abstract class LocalStorage {
  //! Authentication section
  // returns the user if it exists
  // or null otherwise
  Future<User> autoSigninUser();
  
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
  final FirebaseAuth firebaseAuth;
  LocalStorageImpl({this.sharedPreferences, this.firebaseAuth});

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

  @override
  Future<User> autoSigninUser() async {
    return firebaseAuth.currentUser;
  }
}
