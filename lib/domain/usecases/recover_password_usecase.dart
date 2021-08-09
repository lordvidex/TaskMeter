import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../data/repositories/auth_repository.dart';

class RecoverPasswordUseCase {
  final AuthenticationRepository authRepo;
  RecoverPasswordUseCase({this.authRepo});
  Future<Either<Failure, void>> call(String email) =>
      authRepo.recoverPassword(email);
}
