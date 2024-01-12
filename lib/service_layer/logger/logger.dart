import 'package:flutter/foundation.dart';

class Logger {
  static Logger? _instance;
  static Logger get instance {
    if (_instance != null) return _instance!;
    _instance = Logger._init();
    return _instance!;
  }

  Logger._init();

  void log(
    String message,
  ) {
    if (kDebugMode /* || TestDeviceService.instance.isTestDevice */) {
      print(message);
    }
  }

  void inspect(dynamic object) {
    if (kDebugMode) {
      inspect(object);
    }
  }
}
