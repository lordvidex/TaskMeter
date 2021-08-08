import 'package:task_meter/core/utils/merge_utils.dart';

import '../../data/datasources/local_storage.dart';
import '../../data/datasources/remote_storage.dart';
import '../../domain/models/settings.dart';

abstract class SettingsRepository {
  /// Fetch settings from database
  Future<Settings> fetchSettings();

  /// update setting in the database
  Future<void> updateSettings(Settings newSetting, {DateTime time});

  /// returns true if user is logged in for the first time
  /// returns false otherwise
  bool get isFirstTimeUser;

  /// sets
  set isFirstTimeUser(bool value);
}

class SettingsRepositoryImpl extends SettingsRepository {
  final LocalStorage _localStorage;
  final RemoteStorage _remoteStorage;
  SettingsRepositoryImpl(
      {LocalStorage localStorage, RemoteStorage remoteStorage})
      : assert(localStorage != null),
        assert(remoteStorage != null),
        _localStorage = localStorage,
        _remoteStorage = remoteStorage;
  @override
  Future<Settings> fetchSettings() async {
    final remoteSettings = await _remoteStorage.fetchSettings();
    final localSettings = await _localStorage.fetchSettings();
    if (remoteSettings == null) {
      updateSettings(localSettings);
      return localSettings;
    }
    final latestSettings =
        MergeUtils.mergeSettings(remoteSettings, localSettings);
    updateSettings(latestSettings, time: latestSettings.timeOfUpload);
    return latestSettings;
  }

  @override
  Future<void> updateSettings(Settings newSetting, {DateTime time}) async {
    newSetting.setUpdateTime(time ?? DateTime.now());
    try {
      await _remoteStorage.updateSettings(newSetting);
    } catch (e) {
      print(e);
    }
    await _localStorage.updateSettings(newSetting);
  }

  @override
  bool get isFirstTimeUser => _localStorage.isFirstTimeUser;

  @override
  set isFirstTimeUser(bool value) => _localStorage.isFirstTimeUser = value;
}
