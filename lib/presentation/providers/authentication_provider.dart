import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_meter/domain/usecases/google_signin_usecase.dart';
import 'package:task_meter/domain/usecases/google_signup_usecase.dart';

import '../../core/failures.dart';
import '../../domain/usecases/auto_login_usecase.dart';
import '../../domain/usecases/email_signin_usecase.dart';
import '../../domain/usecases/email_signup_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AutoLoginUseCase _autoLoginUseCase;
  final LogOutUsecase _logOutUsecase;
  final EmailSignInUseCase _emailSignInUseCase;
  final EmailSignUpUseCase _emailSignUpUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final GoogleSignUpUseCase _googleSignUpUseCase;

  AuthenticationProvider({
    AutoLoginUseCase autoLoginUseCase,
    LogOutUsecase logoutUseCase,
    EmailSignInUseCase emailSignInUseCase,
    EmailSignUpUseCase emailSignUpUseCase,
    GoogleSignInUseCase googleSignInUseCase,
    GoogleSignUpUseCase googleSignUpUseCase,
  })  : _autoLoginUseCase = autoLoginUseCase,
        _logOutUsecase = logoutUseCase,
        _emailSignInUseCase = emailSignInUseCase,
        _emailSignUpUseCase = emailSignUpUseCase,
        _googleSignInUseCase = googleSignInUseCase,
        _googleSignUpUseCase = googleSignUpUseCase;

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

  /// returns null - if successfully signed up
  /// String - error message in case of any error
  Future<String> emailSignIn(String email, String password) async {
    final result = await _emailSignInUseCase(email, password);
    return foldResult(result);
  }

  /// returns null - if successfully signed up
  /// String - error message in case of any error
  Future<String> emailSignUp(String email, String password) async {
    final result = await _emailSignUpUseCase(email, password);
    return foldResult(result);
  }

  Future<String> googleSignIn() async {
    final result = await _googleSignInUseCase();
    return foldResult(result);
  }

  Future<String> googleSignUp() async {
    final result = await _googleSignUpUseCase();
    return foldResult(result);
  }

  String foldResult(Either<Failure, User> result) {
    return result.fold((failure) => failure.toString(), (user) {
      _user = user;
      notifyListeners();
      return null;
    });
  }
}
