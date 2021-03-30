import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/core/errors.dart';
import 'package:task_meter/core/failures.dart';
import 'package:task_meter/core/network/network_info.dart';
import 'package:task_meter/data/datasources/remote_storage.dart';
import 'package:task_meter/data/repositories/auth_repository.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

class RemoteStorageMock extends Mock implements RemoteStorage {}

void main() {
  AuthenticationRepositoryImpl authImpl;
  NetworkInfoMock networkInfoMock;
  RemoteStorageMock remoteMock;
  setUp(() {
    networkInfoMock = NetworkInfoMock();
    remoteMock = RemoteStorageMock();
    authImpl = AuthenticationRepositoryImpl(
      networkInfo: networkInfoMock,
      remoteStorage: remoteMock,
    );
  });

  // global vars
  final tMail = 'asdf@gmail.com';
  final tPass = 'thisIsMyPasswordeheh';
  group('SignInWithMail', () {
    test('should return NetworkFailure when there is no internet access',
        () async {
      // arrange
      when(networkInfoMock.isConnected).thenAnswer((_) async => false);
      // act
      final result = await authImpl.signinUserWithEmail(tMail, tPass);
      // assert
      expect(result, Left(NetworkFailure()));
    });
    test('should call remote\'s signInUser if there is internet access',
        () async {
      // arrange
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
      when(remoteMock.signinUserWithEmail(any, any))
          .thenAnswer((_) async => null);
      // act
      await authImpl.signinUserWithEmail(tMail, tPass);
      // assert
      verify(remoteMock.signinUserWithEmail(tMail, tPass));
    });
    test(
        'should return UserDoesNotExistFailure when user tries to login using wrong mail',
        () async {
      // arrange
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
      when(remoteMock.signinUserWithEmail(any, any))
          .thenThrow(UserDoesNotExistException());
      // act
      final result = await authImpl.signinUserWithEmail(tMail, tPass);
      // assert
      expect(result, Left(UserDoesNotExistFailure()));
    });
  });
  group('SignUpWithEmail', () {
    test('should return NetworkFailure when there is no internet access',
        () async {
      // arrange
      when(networkInfoMock.isConnected).thenAnswer((_) async => false);
      // act
      final result = await authImpl.signupUserWithEmail(tMail, tPass);
      // assert
      expect(result, Left(NetworkFailure()));
    });
    test('should call remote\'s signUpUser if there is internet access',
        () async {
      // arrange
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
      when(remoteMock.signupUserWithEmail(any, any))
          .thenAnswer((_) async => null);
      // act
      await authImpl.signupUserWithEmail(tMail, tPass);
      // assert
      verify(remoteMock.signupUserWithEmail(tMail, tPass));
    });
    test(
        'should return UserExistsFailure if user tries to create account with already existing credentials',
        () async {
      // arrange
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
      when(remoteMock.signupUserWithEmail(any, any))
          .thenThrow(UserExistsException());
      // act
      final result = await authImpl.signupUserWithEmail(tMail, tPass);
      // assert
      expect(result, Left(UserExistsFailure()));
    });
  });
}
