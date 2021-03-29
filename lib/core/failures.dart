import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  String toString() {
    return "Server error! Please try again later";
  }
}

class NetworkFailure extends Failure {
  @override
  String toString() {
    return 'Failed to connect to the internet. Check your internet connection and try again later';
  }
}

class CacheFailure extends Failure {
  @override
  String toString() {
    return 'Failed to save data to device. Please grant permission request and try again later!';
  }
}

class UserExistsFailure extends Failure {
  @override
  String toString() {
    return 'The User with this credential already exist in the database. Please login instead';
  }
}

class UserDoesNotExistFailure extends Failure {
  @override
  String toString() {
    return 'The User with this detail does not exist. Please sign up to create a new account';
  }
}

class WrongCredentialsFailure extends Failure {
  @override
  String toString() {
    return 'You entered wrong credentials! Please try again.';
  }
}

//_-_ Since there will not be phoneVerification: 
// class WrongVerificationCodeFailure extends Failure {}
