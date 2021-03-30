import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_meter/core/failures.dart';

import '../../data/repositories/auth_repository.dart';

class EmailSignUpUseCase {
  final AuthenticationRepository authRepo;
  const EmailSignUpUseCase({this.authRepo});

  Future<Either<Failure, User>> call(String email, String password) async {
    return await authRepo.signupUserWithEmail(email,password);
  }
}
