import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/core/failures.dart';
import 'package:task_meter/domain/usecases/google_signin_usecase.dart';

import 'email_signin_usecase_test.mocks.dart';

void main() {
  late AuthenticationRepoMock authRepoMock;
  late GoogleSignInUseCase googleSignIn;
  setUp(() {
    authRepoMock = AuthenticationRepoMock();
    googleSignIn = GoogleSignInUseCase(authRepo: authRepoMock);
  });
  group('Signin Error cases', () {
    test(
        'should return NetworkFailure when user tries to signin without internet access',
        () async {
      // arrange
      when(authRepoMock.signinUserWithGoogle())
          .thenAnswer((_) async => Left(NetworkFailure()));
      // act
      final result = await googleSignIn();
      // assert
      expect(result, Left(NetworkFailure()));
    });

    test(
        'should return UserDoesNotExistsFailure when user tries to sign in with unknown credientials',
        () async {
      // arrange
      when(authRepoMock.signinUserWithGoogle())
          .thenAnswer((_) async => Left(UserDoesNotExistFailure()));
      // act
      final result = await googleSignIn();
      // assert
      expect(result, Left(UserDoesNotExistFailure()));
    });

    test(
        'should return WrongCredentialsFailure when user provides invalid credentials',
        () async {
      // arrange
      when(authRepoMock.signinUserWithGoogle())
          .thenAnswer((_) async => Left(WrongCredentialsFailure()));
      // act
      final result = await googleSignIn();
      // assert
      expect(result, Left(WrongCredentialsFailure()));
    });
  });
  group('SignIn Success cases', () {
    //FirebaseUser has no constructors :(
  });
}
