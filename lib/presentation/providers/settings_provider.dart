import 'package:flutter/material.dart';

import '../../domain/models/app_theme.dart';
import '../../domain/models/settings.dart';
import '../../data/repositories/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  Settings? _settings;
  SettingsRepository? _settingsRepository;
  List<FocusNode> _onboardingFocusNodes;

  SettingsProvider({SettingsRepository? settingsRepo})
      : _settingsRepository = settingsRepo,
        _onboardingFocusNodes =
            List.generate(7, (index) => FocusNode(), growable: false);

  Settings? get settings => _settings;

  List<FocusNode> get onboardingFocusNodes => _onboardingFocusNodes;
  Future<void> loadSettings() async {
    _settings = await _settingsRepository!.fetchSettings();
    notifyListeners();
  }

  void updateSettings(Settings? newSetting) async {
    _settings = newSetting;
    notifyListeners();
    await _settingsRepository!.updateSettings(newSetting);
  }

  void updateTheme(AppTheme newTheme) {
    _settings!.appTheme = newTheme;
    updateSettings(_settings);
  }

  void updateLanguage(String languageCode) {
    _settings!.language = languageCode;
    updateSettings(_settings);
  }

  bool get isFirstTimeUser => _settingsRepository!.isFirstTimeUser;
  set isFirstTimeUser(bool value) =>
      _settingsRepository!.isFirstTimeUser = value;

  bool get hasPassedTutorial => _settingsRepository!.hasPassedTutorial;
  set hasPassedTutorial(bool value) =>
      _settingsRepository!.hasPassedTutorial = value;
}
