import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';

class AutoLoginUseCase {
  final AuthenticationRepository authRepo;
  const AutoLoginUseCase({this.authRepo});
  Future<User> call() async => await authRepo.autoLoginUser();
}
