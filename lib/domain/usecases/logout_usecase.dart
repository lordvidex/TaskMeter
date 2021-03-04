import 'package:dartz/dartz.dart';
import 'package:task_meter/core/failures.dart';

import '../../data/repositories/auth_repository.dart';

class LogOutUsecase {
  final AuthenticationRepository authRepo;
  const LogOutUsecase({this.authRepo});

  Future<Either<Failure, bool>> call() async {
    return await authRepo.logoutUser();
  }
}
