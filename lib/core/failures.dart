import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class CacheFailure extends Failure {}

class UserExistsFailure extends Failure {}

class UserDoesNotExistFailure extends Failure {}

class WrongCredentialsFailure extends Failure {}

//_-_ Since there will not be phoneVerification: 
// class WrongVerificationCodeFailure extends Failure {}
