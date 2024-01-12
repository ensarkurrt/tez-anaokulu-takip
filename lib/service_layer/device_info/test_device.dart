import 'package:kindergarden_mobile/service_layer/device_info/device_info.dart';

import '../logger/logger.dart';

class TestDeviceService {
  static TestDeviceService? _instance;
  static TestDeviceService get instance {
    if (_instance != null) return _instance!;
    _instance = TestDeviceService._init();
    return _instance!;
  }

  TestDeviceService._init();

  final List<String> _deviceIds = [];
  List<String> get deviceIds => _deviceIds;

  bool get isTestDevice {
    String deviceId = DeviceInfoService.instance.deviceIdentifier;
    Logger.instance.log("TestDeviceService: isTestDevice: $deviceId");
    return _deviceIds.contains(deviceId);
  }
}
