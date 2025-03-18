import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetInf {
  Future<bool>? get isConnected;
  }

  class NetInfIm implements NetInf{
    final DataConnectionChecker connectionChecker;

    NetInfIm(this.connectionChecker);
    
      @override
      
      Future<bool> get isConnected => connectionChecker.hasConnection;
  }