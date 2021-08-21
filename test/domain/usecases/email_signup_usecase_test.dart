import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/core/failures.dart';
import 'package:task_meter/domain/usecases/email_signup_usecase.dart';

import 'email_signin_usecase_test.mocks.dart';

void main() {
  late AuthenticationRepoMock authRepoMock;
  late EmailSignUpUseCase emailSignUp;
  setUp(() {
    authRepoMock = AuthenticationRepoMock();
    emailSignUp = EmailSignUpUseCase(authRepo: authRepoMock);
  });
  group('Signin Error cases', () {
    final tEmail = 'druid9dev@gmail.com';
    final tPass = 'well,it\'adruid';
    test(
        'should return NetworkFailure when user tries to signup without internet access',
        () async {
      // arrange
      when(authRepoMock.signupUserWithEmail(any, any))
          .thenAnswer((_) async => Left(NetworkFailure()));
      // act
      final result = await emailSignUp(tEmail, tPass);
      // assert
      expect(result, Left(NetworkFailure()));
    });

    test(
        'should return UserExistsFailure when user tries to sign in with unknown credientials',
        () async {
      // arrange
      when(authRepoMock.signupUserWithEmail(any, any))
          .thenAnswer((_) async => Left(UserExistsFailure()));
      // act
      final result = await emailSignUp(tEmail, tPass);
      // assert
      expect(result, Left(UserExistsFailure()));
    });
  });
  group('SignUp Success cases', () {
    //FirebaseUser has no constructors :(
  });
}
