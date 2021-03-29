import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker checker;
  NetworkInfoImpl(this.checker);
  @override
  Future<bool> get isConnected async => await checker.hasConnection;
}