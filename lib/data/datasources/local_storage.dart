import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/settings.dart';
import '../../domain/models/task_group.dart';

const String SETTINGS = 'settings';
const String TASKGROUPS = 'task_groups';
const String LAST_TASKGROUP_UPDATE_TIME = 'time';
const String IS_NEW_USER = 'is_new_user';

abstract class LocalStorage {
  //! Authentication section
  // returns the user if it exists
  // or null otherwise
  Future<User> autoSigninUser();
  Future<void> logoutUser();

  //! Settings section
  /// Fetches the saved settings from the Database
  /// Returns `default` values for settings if user does not have saved data
  Future<Settings> fetchSettings();

  /// Update settings in the local database
  Future<void> updateSettings(Settings newSettings);

  /// fetches the List of taskGroups from the database
  Future<List<TaskGroup>> fetchTaskGroups();

  /// fetches the time to the last update to the local database
  Future<DateTime> getLastTaskGroupUpdateTime();

  /// updates taskGroups in the database with the time they were added
  Future<void> updateTaskGroups(
      List<TaskGroup> taskGroups, DateTime timeOfUpdate);

  /// returns true if user is new
  bool get isFirstTimeUser;

  /// sets false to is first time user
  set isFirstTimeUser(bool value);
}

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences sharedPreferences;
  final FirebaseAuth firebaseAuth;
  LocalStorageImpl({this.sharedPreferences, this.firebaseAuth});

  @override
  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
  }

  bool get isFirstTimeUser {
    try {
      return sharedPreferences.getBool(IS_NEW_USER) ?? true;
    } catch (_) {
      return true;
    }
  }

  set isFirstTimeUser(bool value) =>
      sharedPreferences.setBool(IS_NEW_USER, false);

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
          .skipWhile((tg) => tg.isDeleted ?? false)
          .toList();
    } else {
      //! the local storage is either empty or there was an error
      return [];
    }
  }

  @override
  Future<void> updateTaskGroups(
      List<TaskGroup> taskGroups, DateTime timeOfUpdate) async {
    bool updated = await sharedPreferences.setStringList(
        TASKGROUPS, taskGroups.map((tg) => json.encode(tg.toJson())).toList());
    if (updated) {
      await sharedPreferences.setString(
          LAST_TASKGROUP_UPDATE_TIME, timeOfUpdate.toIso8601String());
    }
  }

  @override
  Future<User> autoSigninUser() async {
    return firebaseAuth.currentUser;
  }

  @override
  Future<DateTime> getLastTaskGroupUpdateTime() async => DateTime.tryParse(
      sharedPreferences.getString(LAST_TASKGROUP_UPDATE_TIME));
}
