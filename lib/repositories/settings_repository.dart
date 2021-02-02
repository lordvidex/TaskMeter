import 'package:task_meter/data/local_storage.dart';

import '../models/settings.dart';

abstract class SettingsRepository {
  /// Fetch settings from database
  Future<Settings> getSettings();

  /// update setting in the database
  Future<void> updateSettings(Settings newSetting);
}

class SettingsRepositoryImpl extends SettingsRepository {
  final LocalStorage _localStorage;
  SettingsRepositoryImpl({LocalStorage localStorage})
      : assert(localStorage != null),
        _localStorage = localStorage;
  @override
  Future<Settings> getSettings() {
    return _localStorage.fetchSettings();
  }

  @override
  Future<void> updateSettings(Settings newSetting) {
    return _localStorage.updateSettings(newSetting);
  }
}
