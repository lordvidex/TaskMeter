import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failures.dart';
import '../../data/repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthenticationRepository authRepo;
  const GoogleSignInUseCase({this.authRepo});

  Future<Either<Failure, User>> call() async {
    return await authRepo.signinUserWithGoogle();
  }
}
