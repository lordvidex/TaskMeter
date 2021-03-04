import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final DataConnectionChecker checker;
  NetworkInfoImpl(this.checker);
  @override
  Future<bool> get isConnected async => await checker.hasConnection;
}