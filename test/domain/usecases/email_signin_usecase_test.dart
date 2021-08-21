import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/core/failures.dart';
import 'package:task_meter/data/repositories/auth_repository.dart';
import 'package:task_meter/domain/usecases/email_signin_usecase.dart';

import 'email_signin_usecase_test.mocks.dart';

@GenerateMocks([],customMocks: [MockSpec<AuthenticationRepository>(as: #AuthenticationRepoMock)])
void main() {
  late AuthenticationRepoMock authRepoMock;
  late EmailSignInUseCase emailSignIn;
  setUp(() {
    authRepoMock = AuthenticationRepoMock();
    emailSignIn = EmailSignInUseCase(authRepo: authRepoMock);
  });
  group('Signin Error cases', () {
    final tEmail = 'druid9dev@gmail.com';
    final tPass = 'well,it\'adruid';
    test(
        'should return NetworkFailure when user tries to signin without internet access',
        () async {
      // arrange
      when(authRepoMock.signinUserWithEmail(any, any))
          .thenAnswer((_) async => Left(NetworkFailure()));
      // act
      final result = await emailSignIn(tEmail, tPass);
      // assert
      expect(result, Left(NetworkFailure()));
    });

    test(
        'should return UserDoesNotExistsFailure when user tries to sign in with unknown credientials',
        () async {
      // arrange
      when(authRepoMock.signinUserWithEmail(any, any))
          .thenAnswer((_) async => Left(UserDoesNotExistFailure()));
      // act
      final result = await emailSignIn(tEmail, tPass);
      // assert
      expect(result, Left(UserDoesNotExistFailure()));
    });

    test('should return WrongCredentialsFailure when user provides invalid credentials',() async {
     // arrange 
    when(authRepoMock.signinUserWithEmail(any,any)).thenAnswer((_)async=>Left(WrongCredentialsFailure()));
     // act
      final result = await emailSignIn(tEmail,tPass);
     // assert
     expect(result, Left(WrongCredentialsFailure()));
    
    });
  });
  group('SignIn Success cases', () {
   //FirebaseUser has no constructors :(
});
}
