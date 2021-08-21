import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failures.dart';
import '../../data/repositories/auth_repository.dart';

class GoogleSignUpUseCase {
  final AuthenticationRepository? authRepo;
  const GoogleSignUpUseCase({this.authRepo});

  Future<Either<Failure, User?>> call() async {
    return await authRepo!.signUpUserWithGoogle();
  }
}