import 'package:flutter/foundation.dart';

import '../models/settings.dart';
import '../repositories/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  Settings _settings;
  SettingsRepository _settingsRepository;
  SettingsProvider({SettingsRepository settingsRepo})
      : _settingsRepository = settingsRepo {
    loadSettings();
  }
  Settings get settings => _settings;
  Future<void> loadSettings() async {
    _settings = await _settingsRepository.getSettings();
    notifyListeners();
  }

  updateSettings(Settings newSetting) {
    _settings = newSetting;
    notifyListeners();
    _settingsRepository.updateSettings(newSetting);
  }
}
