import 'package:task_meter/domain/models/task_group.dart';

import '../../domain/models/settings.dart';

class MergeUtils {
  static Settings mergeSettings(
      Settings remoteSettings, Settings localSettings) {
    if (localSettings == Settings.defaultSettings() ||
        remoteSettings.timeOfUpload.isAfter(localSettings.timeOfUpload))
      return remoteSettings;
    else
      return localSettings;
  }
}
