import 'package:kindergarden_mobile/service_layer/device_info/device_info.dart';
import 'package:kindergarden_mobile/tools/constants/application_constants.dart';

class VersionService {
  static VersionService? _instance;
  static VersionService get instance {
    if (_instance != null) return _instance!;
    _instance = VersionService._init();
    return _instance!;
  }

  VersionService._init() {
    DeviceInfoService.instance;
    ApplicationConstants.instance;
  }

  bool get isForceUpdate => ApplicationConstants.instance.forceUpdateBuildNumber > int.parse(DeviceInfoService.instance.appBuild);
  bool get isSoftUpdate => ApplicationConstants.instance.softUpdateBuildNumber > int.parse(DeviceInfoService.instance.appBuild);
}
