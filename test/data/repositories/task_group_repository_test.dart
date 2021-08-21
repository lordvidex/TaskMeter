import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/data/datasources/local_storage.dart';
import 'package:task_meter/data/datasources/remote_storage.dart';
import 'package:task_meter/data/repositories/task_group_repository.dart';
import 'package:task_meter/domain/models/task_group.dart';
import 'task_group_repository_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<LocalStorage>(as: #LocalStorageMock),
  MockSpec<RemoteStorage>(as: #RemoteStorageMock)
])
void main() {
  late TaskGroupRepositoryImpl taskGroupRepositoryImpl;
  late LocalStorageMock localStorageMock;
  late RemoteStorageMock remoteStorageMock;
  setUp(() {
    localStorageMock = LocalStorageMock();
    remoteStorageMock = RemoteStorageMock();
    taskGroupRepositoryImpl = TaskGroupRepositoryImpl(
        localStorage: localStorageMock, remoteStorage: remoteStorageMock);
  });

  group('Fetching TaskGroups', () {
    final tLocal = [TaskGroup('t1')];
    final tRemote = [TaskGroup('t2'), TaskGroup('t3')];
    test(
        'should return an empty list of taskGroups when both local and remote have no data',
        () async {
      // arrange

      //! no time of last updated
      when(localStorageMock.getLastTaskGroupUpdateTime())
          .thenAnswer((_) async => null);
      when(remoteStorageMock.getLastTaskGroupUpdateTime())
          .thenAnswer((_) async => null);
      //! no data also
      when(localStorageMock.fetchTaskGroups())
          .thenAnswer((realInvocation) async => []);

      when(remoteStorageMock.fetchTaskGroups())
          .thenAnswer((realInvocation) async => []);
      // act
      final result = await taskGroupRepositoryImpl.fetchTaskGroups();
      // assert
      expect(result, []);
    });

    test('should return remoteData if localData is more outdated', () async {
      // arrange

      //! times
      when(localStorageMock.getLastTaskGroupUpdateTime())
          .thenAnswer((_) async => DateTime.now().subtract(Duration(hours: 1)));
      when(remoteStorageMock.getLastTaskGroupUpdateTime())
          .thenAnswer((_) async => DateTime.now());
      //! data
      when(localStorageMock.fetchTaskGroups())
          .thenAnswer((realInvocation) async => tLocal);
      when(remoteStorageMock.fetchTaskGroups())
          .thenAnswer((realInvocation) async => tRemote);
      // act
      final result = await taskGroupRepositoryImpl.fetchTaskGroups();
      // assert
      expect(result, tRemote);
    });
  });
}
