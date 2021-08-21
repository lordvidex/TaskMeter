import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/core/errors.dart';
import 'package:task_meter/core/failures.dart';
import 'package:task_meter/core/network/network_info.dart';
import 'package:task_meter/data/repositories/auth_repository.dart';

import 'auth_repository_test.mocks.dart';
import 'task_group_repository_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<NetworkInfo>(as: #NetworkInfoMock)])
void main() {
  late AuthenticationRepositoryImpl authImpl;
  late NetworkInfoMock networkInfoMock;
  late RemoteStorageMock remoteMock;
  setUp(() {
    networkInfoMock = NetworkInfoMock();
    remoteMock = RemoteStorageMock();
    authImpl = AuthenticationRepositoryImpl(
      networkInfo: networkInfoMock,
      remoteStorage: remoteMock,
    );
  });
  void mockNetwork(bool value) =>
      when(networkInfoMock.isConnected).thenAnswer((_) async => value);
  group('Email', () {
    // test mail and password
    final tMail = 'asdf@gmail.com';
    final tPass = 'thisIsMyPasswordeheh';
    group('SignInWithMail', () {
      test('should return NetworkFailure when there is no internet access',
          () async {
        // arrange
        mockNetwork(false);
        // act
        final result = await authImpl.signinUserWithEmail(tMail, tPass);
        // assert
        expect(result, Left(NetworkFailure()));
      });
      test('should call remote\'s signInUser if there is internet access',
          () async {
        // arrange
        mockNetwork(true);
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
        mockNetwork(true);
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
        mockNetwork(false);
        // act
        final result = await authImpl.signupUserWithEmail(tMail, tPass);
        // assert
        expect(result, Left(NetworkFailure()));
      });
      test('should call remote\'s signUpUser if there is internet access',
          () async {
        // arrange
        mockNetwork(true);
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
        mockNetwork(true);
        when(remoteMock.signupUserWithEmail(any, any))
            .thenThrow(UserExistsException());
        // act
        final result = await authImpl.signupUserWithEmail(tMail, tPass);
        // assert
        expect(result, Left(UserExistsFailure()));
      });
    });
  });

  group('Google', () {
    group('SignInWithGoogle', () {
      test('should return NetworkFailure when there is no internet access',
          () async {
        // arrange
        mockNetwork(false);
        // act
        final result = await authImpl.signinUserWithGoogle();
        // assert
        expect(result, Left(NetworkFailure()));
      });
      test('should call remote\'s signInUser if there is internet access',
          () async {
        // arrange
        mockNetwork(true);
        when(remoteMock.signinUserWithGoogle()).thenAnswer((_) async => null);
        // act
        await authImpl.signinUserWithGoogle();
        // assert
        verify(remoteMock.signinUserWithGoogle());
      });
      test(
          'should return CredentialFailure when getting OAuthCredential failed',
          () async {
        // arrange
        mockNetwork(true);
        when(remoteMock.signinUserWithGoogle())
            .thenThrow(CredentialException(Social.Google));
        // act
        final result = await authImpl.signinUserWithGoogle();
        // assert
        expect(result, Left(CredentialFailure(Social.Google)));
      });

      test('should return UserExistsFailure when UserExistsException is thrown',
          () async {
        // arrange
        mockNetwork(true);
        when(remoteMock.signinUserWithGoogle())
            .thenThrow(UserExistsException());
        // act
        final user = await authImpl.signUpUserWithGoogle();
        // assert
        expect(user, Left(UserExistsFailure()));
      });
    });
  });
}
