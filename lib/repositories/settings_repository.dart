import '../models/settings.dart';

abstract class SettingsRepository {
  /// Fetch settings from database
  Future<Settings> getSettings();
  /// update setting in the database
  Future<void> updateSettings(Settings newSetting);
}
