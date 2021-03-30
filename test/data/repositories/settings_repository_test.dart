import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/data/datasources/local_storage.dart';
import 'package:task_meter/data/datasources/remote_storage.dart';
import 'package:task_meter/domain/models/settings.dart';
import 'package:task_meter/data/repositories/settings_repository.dart';

class LocalStorageMock extends Mock implements LocalStorage {}

class RemoteStorageMock extends Mock implements RemoteStorage {}

void main() {
  SettingsRepositoryImpl settingsRepo;
  LocalStorageMock localStorageMock;
  RemoteStorageMock remoteStorageMock;
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
      when(remoteStorageMock.fetchSettings())
          .thenAnswer((_) async => Settings(timeOfUpload: now));
      when(localStorageMock.fetchSettings())
          .thenAnswer((_) async => Settings(timeOfUpload: lateTime));
      // act
      final settings = await settingsRepo.fetchSettings();
      // assert
      expect(settings, Settings(timeOfUpload: now));
    });
  });
}
