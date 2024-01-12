import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:shake/shake.dart';

class ShakeManager {
  static ShakeManager? _instance;
  static ShakeManager get instance {
    if (_instance != null) return _instance!;
    _instance = ShakeManager._init();
    return _instance!;
  }

  ShakeManager._init() {
    if (kDebugMode) {
      ShakeDetector.autoStart(onPhoneShake: () => ChuckerFlutter.showChuckerScreen(), minimumShakeCount: 2);
    }
  }
}
