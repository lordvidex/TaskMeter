import 'package:flutter/foundation.dart';

import '../models/app_theme.dart';
import '../models/settings.dart';
import '../repositories/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  Settings _settings;
  SettingsRepository _settingsRepository;
  SettingsProvider({SettingsRepository settingsRepo})
      : _settingsRepository = settingsRepo;
  Settings get settings => _settings;
  Future<void> loadSettings() async {
    _settings = await _settingsRepository.fetchSettings();
    notifyListeners();
  }

  void updateSettings(Settings newSetting) async {
    _settings = newSetting;
    notifyListeners();
    await _settingsRepository.updateSettings(newSetting);
  }

  void updateTheme(AppTheme newTheme) {
    _settings.appTheme = newTheme;
    updateSettings(_settings);
  }

  void updateLanguage(String languageCode) {
    _settings.language = languageCode;
    updateSettings(_settings);
  }
}
