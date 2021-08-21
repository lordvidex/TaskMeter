import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/domain/models/settings.dart';
import 'package:task_meter/data/repositories/settings_repository.dart';

import 'task_group_repository_test.mocks.dart';


void main() {
  late SettingsRepositoryImpl settingsRepo;
  late LocalStorageMock localStorageMock;
  late RemoteStorageMock remoteStorageMock;
  setUp(() {
    localStorageMock = LocalStorageMock();
    remoteStorageMock = RemoteStorageMock();
    settingsRepo = SettingsRepositoryImpl(
        localStorage: localStorageMock, remoteStorage: remoteStorageMock);
  });

  group('FetchSettings', () {
    test(
        'should return localSettings when there is no internet access/ when remoteSettings is null',
        () async {
      // arrange
      when(remoteStorageMock.fetchSettings()).thenAnswer((_) async => null);
      when(localStorageMock.fetchSettings())
          .thenAnswer((_) async => Settings.defaultSettings());
      // act
      final settings = await settingsRepo.fetchSettings();
      // assert
      expect(settings, Settings.defaultSettings());
    });

    test(
        'should return the latest settings when we have a local setting and a remote setting',
        () async {
      // arrange
      final now = DateTime.now();
      final lateTime = DateTime.now().subtract(Duration(hours: 1));
      when(remoteStorageMock.fetchSettings()).thenAnswer((_) async => Settings(
          timeOfUpload: now,
          longBreak: Duration.zero,
          totalTime: Duration.zero,
          longBreakIntervals: 1,
          shortBreak: Duration.zero));
      when(localStorageMock.fetchSettings()).thenAnswer((_) async => Settings(
          timeOfUpload: lateTime,
          longBreak: Duration.zero,
          totalTime: Duration.zero,
          longBreakIntervals: 1,
          shortBreak: Duration.zero));
      // act
      final settings = await settingsRepo.fetchSettings();
      // assert
      expect(
          settings,
          Settings(
              timeOfUpload: now,
              longBreak: Duration.zero,
              totalTime: Duration.zero,
              longBreakIntervals: 1,
              shortBreak: Duration.zero));
    });
  });
}
