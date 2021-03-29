import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_meter/core/failures.dart';
import 'package:task_meter/domain/usecases/auto_login_usecase.dart';
import 'package:task_meter/domain/usecases/email_signin_usecase.dart';
import 'package:task_meter/domain/usecases/email_signup_usecase.dart';
import 'package:task_meter/domain/usecases/logout_usecase.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AutoLoginUseCase _autoLoginUseCase;
  final LogOutUsecase _logOutUsecase;
  final EmailSignInUseCase _emailSignInUseCase;
  final EmailSignUpUseCase _emailSignUpUseCase;

  AuthenticationProvider({
    AutoLoginUseCase autoLoginUseCase,
    LogOutUsecase logoutUseCase,
    EmailSignInUseCase emailSignInUseCase,
    EmailSignUpUseCase emailSignUpUseCase,
  })  : _autoLoginUseCase = autoLoginUseCase,
        _logOutUsecase = logoutUseCase,
        _emailSignInUseCase = emailSignInUseCase,
        _emailSignUpUseCase = emailSignUpUseCase;

  User _user;

  User get user => _user;

  Future<void> autoLogin() async {
    _user = await _autoLoginUseCase();
  }

  Future<void> logOut() async {
    // removes the user from localStorage
    await _logOutUsecase();
    // invalidate current authentication session
    _user = null;
    notifyListeners();
  }

  Future<String> emailSignIn(String email, String password) async {
    final result = await _emailSignInUseCase(email, password);
    return result.fold((failure) {
      return _parseFailureResponse(failure);
    }, (user) {
      _user = user;
      notifyListeners();
      return null;
    });
  }

  Future<String> emailSignUp(String email, String password) async {
    final result = await _emailSignUpUseCase(email, password);
    return result.fold((failure) {
      return _parseFailureResponse(failure);
    }, (user) {
      _user = user;
      notifyListeners();
      return null;
    });
  }

  String _parseFailureResponse(Failure failure) {
    return failure.toString();
  }
}
