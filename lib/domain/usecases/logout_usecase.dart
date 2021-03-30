import '../../data/repositories/auth_repository.dart';

class LogOutUsecase {
  final AuthenticationRepository authRepo;
  const LogOutUsecase({this.authRepo});

  Future<void> call() async {
    return await authRepo.logoutUser();
  }
}
