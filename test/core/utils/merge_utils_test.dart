import 'package:flutter_test/flutter_test.dart';
import 'package:task_meter/core/utils/merge_utils.dart';
import 'package:task_meter/models/settings.dart';

void main() {
  Settings localSettings = Settings.defaultSettings();
  Settings remoteSettings = Settings(
      totalTime: Duration(hours: 1),
      longBreak: Duration(minutes: 5),
      shortBreak: Duration(minutes: 1),
      longBreakIntervals: 3,
      timeOfUpload: DateTime.now());

  test(
      'should return remote settings when localsettings is either default settings with no time of upload',
      () {
    // arrange
    assert(localSettings != null);
    assert(remoteSettings != null);

    // act
    final settings = MergeUtils.mergeSettings(remoteSettings, localSettings);
    // assert
    expect(settings, remoteSettings);
  });
}
