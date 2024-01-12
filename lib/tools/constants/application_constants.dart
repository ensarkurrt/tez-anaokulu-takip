import 'package:kindergarden_mobile/tools/constants/remote_config_constants.dart';

import '../../service_layer/firebase/firebase_remote_config.dart';

class ApplicationConstants {
  static ApplicationConstants? _instance;
  static ApplicationConstants get instance {
    if (_instance != null) return _instance!;
    _instance = ApplicationConstants._init();
    return _instance!;
  }

  ApplicationConstants._init();
  String get appName => "My AI";
  String get backendUrl => FirebaseRemoteConfigService.instance.getString(RemoteConfigConstants.BACKEND_URL, locale: false);
  String get s3BucketUrl => FirebaseRemoteConfigService.instance.getString(RemoteConfigConstants.S3_BUCKET_URL, locale: false);
  int get forceUpdateBuildNumber => FirebaseRemoteConfigService.instance.getInt(RemoteConfigConstants.FORCE_UPDATE_BUILD_NUMBER, locale: false);
  int get softUpdateBuildNumber => FirebaseRemoteConfigService.instance.getInt(RemoteConfigConstants.SOFT_UPDATE_BUILD_NUMBER, locale: false);
}
