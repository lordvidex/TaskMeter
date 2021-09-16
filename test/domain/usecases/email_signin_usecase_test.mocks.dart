// Mocks generated by Mockito 5.0.14 from annotations
// in task_meter/test/domain/usecases/email_signin_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:task_meter/core/failures.dart' as _i5;
import 'package:task_meter/data/repositories/auth_repository.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class AuthenticationRepoMock extends _i1.Mock
    implements _i3.AuthenticationRepository {
  AuthenticationRepoMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> signinUserWithEmail(
          String? email, String? password) =>
      (super.noSuchMethod(
              Invocation.method(#signinUserWithEmail, [email, password]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
                  _FakeEither_0<_i5.Failure, _i6.User?>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> signinUserWithGoogle() =>
      (super.noSuchMethod(Invocation.method(#signinUserWithGoogle, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
                  _FakeEither_0<_i5.Failure, _i6.User?>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> signinUserWithApple() =>
      (super.noSuchMethod(Invocation.method(#signinUserWithApple, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.User>>.value(
                  _FakeEither_0<_i5.Failure, _i6.User>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i6.User?> autoLoginUser() =>
      (super.noSuchMethod(Invocation.method(#autoLoginUser, []),
          returnValue: Future<_i6.User?>.value()) as _i4.Future<_i6.User?>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> signUpUserWithGoogle() =>
      (super.noSuchMethod(Invocation.method(#signUpUserWithGoogle, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
                  _FakeEither_0<_i5.Failure, _i6.User?>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> signupUserWithApple() =>
      (super.noSuchMethod(Invocation.method(#signupUserWithApple, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.User>>.value(
                  _FakeEither_0<_i5.Failure, _i6.User>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> signupUserWithEmail(
          String? email, String? password) =>
      (super.noSuchMethod(
              Invocation.method(#signupUserWithEmail, [email, password]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
                  _FakeEither_0<_i5.Failure, _i6.User?>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> recoverPassword(String? email) =>
      (super.noSuchMethod(Invocation.method(#recoverPassword, [email]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<void> logoutUser() =>
      (super.noSuchMethod(Invocation.method(#logoutUser, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}