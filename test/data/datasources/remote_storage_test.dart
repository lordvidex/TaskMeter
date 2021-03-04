import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/core/errors.dart';
import 'package:task_meter/data/datasources/remote_storage.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  FirebaseAuthMock firebaseAuthMock;
  RemoteStorageImpl remoteStorage;
  setUp(() {
    firebaseAuthMock = FirebaseAuthMock();
    remoteStorage = RemoteStorageImpl(firebaseAuth: firebaseAuthMock);
  });

  group('Email signIn and signUp', () {
    final tMail = 'asdfasdfa@gmail.com';
    final tPass = 'asedfasdg3234';
    test(
        'should return UserExists when user tries to signup with already used credentials',
        () async {
      // arrange
      final errorCode = 'email-already-in-use';
      when(firebaseAuthMock.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(FirebaseAuthException(code: errorCode));
      // act
      final call = remoteStorage.signupUserWithEmail(tMail, tPass);
      // assert
      expect(() => call, throwsA(isA<UserExistsException>()));
    });
  });
}
