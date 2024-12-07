import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final InternetConnection connection;

  const NetworkInfo({required this.connection});

  @override
  Future<bool> get isConnected => connection.hasInternetAccess;
}
