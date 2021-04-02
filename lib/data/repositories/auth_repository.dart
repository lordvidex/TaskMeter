import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors.dart';
import '../../core/failures.dart';
import '../../core/network/network_info.dart';
import '../datasources/local_storage.dart';
import '../datasources/remote_storage.dart';

abstract class AuthenticationRepository {
  //! SignIn
  // logs in user with email
  Future<Either<Failure, User>> signinUserWithEmail(
      String email, String password);

  // logs in user with google
  Future<Either<Failure, User>> signinUserWithGoogle();

  // logs in user with apple
  Future<Either<Failure, User>> signinUserWithApple();

  // auto logs in user during startup
  // returns null if user is not authenticated
  Future<User> autoLoginUser();

  //! SignUp
  // Sign up user with google
  Future<Either<Failure, User>> signUpUserWithGoogle();

  // Sign up user with apple
  Future<Either<Failure, User>> signupUserWithApple();

  // signs up user freshly with mail
  Future<Either<Failure, User>> signupUserWithEmail(
      String email, String password);

  // logs out user
  Future<void> logoutUser();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo _networkInfo;
  final RemoteStorage _remoteStorage;
  final LocalStorage _localStorage;
  const AuthenticationRepositoryImpl({
    NetworkInfo networkInfo,
    RemoteStorage remoteStorage,
    LocalStorage localStorage,
  })  : _networkInfo = networkInfo,
        _remoteStorage = remoteStorage,
        _localStorage = localStorage;

  //! Auto login
  @override
  Future<User> autoLoginUser() {
    return _localStorage.autoSigninUser();
  }

  //! logOut
  @override
  Future<void> logoutUser() async {
    return _localStorage.logoutUser();
  }

  //! Google
  @override
  Future<Either<Failure, User>> signUpUserWithGoogle() async {
    return await signinUserWithGoogle();
  }

  @override
  Future<Either<Failure, User>> signinUserWithGoogle() async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    // Network is good.. fetch the user and catch the errors
    try {
      final _user = await _remoteStorage.signinUserWithGoogle();
      return Right(_user);
    } on CredentialException catch (c) {
      return Left(CredentialFailure(c.socialCredential));
    } on UserExistsException {
      return Left(UserExistsFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //! Apple
  @override
  Future<Either<Failure, User>> signinUserWithApple() {
    // TODO: implement signinUserWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signupUserWithApple() {
    // TODO: implement signupUserWithApple
    throw UnimplementedError();
  }

  //! E-Mail
  @override
  Future<Either<Failure, User>> signinUserWithEmail(
    String email,
    String password,
  ) async {
    // 1. check for internet connection
    // 2. check if the user exists in the database
    // 3. check if the user supplied a wrong password
    // 4. catch anonymous errors
    // 5. return the user when successful
    if (await _networkInfo.isConnected) {
      try {
        final _user = await _remoteStorage.signinUserWithEmail(email, password);
        return Right(_user);
      } on UserDoesNotExistException {
        return Left(UserDoesNotExistFailure());
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } catch (e) {
        // unplanned errors
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signupUserWithEmail(
      String email, String password) async {
    // check for internet connection
    if (await _networkInfo.isConnected) {
      try {
        final signInResult =
            await _remoteStorage.signupUserWithEmail(email, password);
        return Right(signInResult);
      } on UserExistsException {
        return Left(UserExistsFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
