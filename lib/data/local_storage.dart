import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

const String SETTINGS = 'settings';

abstract class LocalStorage {
  /// Fetches the saved settings from the Database
  /// Returns `default` values for settings if user does not have saved data
  Future<Settings> fetchSettings();

  /// Update settings in the local database
  Future<void> updateSettings(Settings newSettings);
}

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences sharedPreferences;
  LocalStorageImpl(this.sharedPreferences);

  @override
  Future<Settings> fetchSettings() async {
    if (sharedPreferences.containsKey(SETTINGS)) {
      //return the settings
      return Settings.fromMap(
          json.decode(sharedPreferences.getString(SETTINGS)));
    } else {
      // return the default settings and save it to the database
      await sharedPreferences.setString(
          SETTINGS, json.encode(Settings.defaultSettings()));
      return Settings.defaultSettings();
    }
  }

  @override
  Future<void> updateSettings(Settings newSettings) async {
    await sharedPreferences.setString(
        SETTINGS, json.encode(newSettings.toMap()));
  }
}
