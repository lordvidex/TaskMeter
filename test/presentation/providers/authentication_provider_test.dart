import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_meter/data/datasources/local_storage.dart';
import 'package:task_meter/data/datasources/remote_storage.dart';
import 'package:task_meter/domain/usecases/auto_login_usecase.dart';
import 'package:task_meter/domain/usecases/email_signin_usecase.dart';
import 'package:task_meter/domain/usecases/email_signup_usecase.dart';
import 'package:task_meter/domain/usecases/logout_usecase.dart';
import 'package:task_meter/presentation/providers/authentication_provider.dart';

class AutoLoginusecaseMock extends Mock implements AutoLoginUseCase {}

class EmailSignInUseCaseMock extends Mock implements EmailSignInUseCase {}

class EmailSignUpUseCaseMock extends Mock implements EmailSignUpUseCase {}

class LogOutUseCaseMock extends Mock implements LogOutUsecase {}

void main() {
  AutoLoginusecaseMock _autoLoginMock;
  EmailSignInUseCaseMock _emailSignIn;
  EmailSignUpUseCaseMock _emailSignUp;
  LogOutUseCaseMock _logout;
  AuthenticationProvider authProvider;
  setUp(() {
    _autoLoginMock = AutoLoginusecaseMock();
    _emailSignUp = EmailSignUpUseCaseMock();
    _emailSignIn = EmailSignInUseCaseMock();
    _logout = LogOutUseCaseMock();
    authProvider = AuthenticationProvider(
        autoLoginUseCase: _autoLoginMock,
        emailSignInUseCase: _emailSignIn,
        emailSignUpUseCase: _emailSignUp,
        logoutUseCase: _logout);
  });

  test('should return null user after logout', () {
    // act
    authProvider.logOut();
    // assert
    expect(authProvider.user, null);
  });
}
