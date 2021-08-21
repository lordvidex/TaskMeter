import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:task_meter/domain/usecases/auto_login_usecase.dart';
import 'package:task_meter/domain/usecases/email_signin_usecase.dart';
import 'package:task_meter/domain/usecases/email_signup_usecase.dart';
import 'package:task_meter/domain/usecases/logout_usecase.dart';
import 'package:task_meter/presentation/providers/authentication_provider.dart';
import 'authentication_provider_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<AutoLoginUseCase>(as: #AutoLoginusecaseMock),
  MockSpec<EmailSignInUseCase>(as: #EmailSignInUseCaseMock),
  MockSpec<EmailSignUpUseCase>(as: #EmailSignUpUseCaseMock),
  MockSpec<LogOutUsecase>(as: #LogOutUseCaseMock)
])
void main() {
  late AutoLoginusecaseMock _autoLoginMock;
  late EmailSignInUseCaseMock _emailSignIn;
  late EmailSignUpUseCaseMock _emailSignUp;
  late LogOutUseCaseMock _logout;
  late AuthenticationProvider authProvider;
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
