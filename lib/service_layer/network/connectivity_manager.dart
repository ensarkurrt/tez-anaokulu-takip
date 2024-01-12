import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kindergarden_mobile/service_layer/firebase/firebase.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:kindergarden_mobile/service_layer/providers/connection_management.dart';

class ConnectivityManager {
  static ConnectivityManager? _instance;
  static ConnectivityManager get instance {
    if (_instance != null) return _instance!;
    _instance = ConnectivityManager._init();
    return _instance!;
  }

  final bool _isConnected = false;
  bool get isConnected => _isConnected;

  ConnectivityManager._init() {
    init();
  }

  Future init() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none || result == ConnectivityResult.bluetooth) {
        Logger.instance.log('ConnectivityManager ::: No internet connection');
        //TODO :: show no internet connection dialog
        //ConnectionManagement.include.state = ConnectState.NotConnected;
      } else {
        Logger.instance.log('ConnectivityManager ::: Internet connection is available');
        ConnectionManagement.include.state = ConnectState.Connected;
        await FirebaseService.instance.initAllServices();
      }
    });
  }

  add(Function(bool) callback) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none || result == ConnectivityResult.bluetooth) {
        Logger.instance.log('ConnectivityManager ::: No internet connection');
        callback(false);
      } else {
        Logger.instance.log('ConnectivityManager ::: Internet connection is available');
        callback(true);
      }
    });
  }
}
