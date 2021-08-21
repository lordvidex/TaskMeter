// Mocks generated by Mockito 5.0.14 from annotations
// in task_meter/test/presentation/providers/authentication_provider_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:task_meter/core/failures.dart' as _i7;
import 'package:task_meter/domain/usecases/auto_login_usecase.dart' as _i3;
import 'package:task_meter/domain/usecases/email_signin_usecase.dart' as _i6;
import 'package:task_meter/domain/usecases/email_signup_usecase.dart' as _i8;
import 'package:task_meter/domain/usecases/logout_usecase.dart' as _i9;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [AutoLoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class AutoLoginusecaseMock extends _i1.Mock implements _i3.AutoLoginUseCase {
  AutoLoginusecaseMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i5.User?> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
          returnValue: Future<_i5.User?>.value()) as _i4.Future<_i5.User?>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [EmailSignInUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class EmailSignInUseCaseMock extends _i1.Mock
    implements _i6.EmailSignInUseCase {
  EmailSignInUseCaseMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i7.Failure, _i5.User?>> call(
          String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#call, [email, password]),
              returnValue: Future<_i2.Either<_i7.Failure, _i5.User?>>.value(
                  _FakeEither_0<_i7.Failure, _i5.User?>()))
          as _i4.Future<_i2.Either<_i7.Failure, _i5.User?>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [EmailSignUpUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class EmailSignUpUseCaseMock extends _i1.Mock
    implements _i8.EmailSignUpUseCase {
  EmailSignUpUseCaseMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i7.Failure, _i5.User?>> call(
          String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#call, [email, password]),
              returnValue: Future<_i2.Either<_i7.Failure, _i5.User?>>.value(
                  _FakeEither_0<_i7.Failure, _i5.User?>()))
          as _i4.Future<_i2.Either<_i7.Failure, _i5.User?>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [LogOutUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class LogOutUseCaseMock extends _i1.Mock implements _i9.LogOutUsecase {
  LogOutUseCaseMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> call() => (super.noSuchMethod(Invocation.method(#call, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}
