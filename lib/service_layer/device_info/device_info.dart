import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../logger/logger.dart';

class DeviceInfoService {
  static DeviceInfoService? _instance;
  static DeviceInfoService get instance {
    if (_instance != null) return _instance!;
    _instance = DeviceInfoService._init();
    return _instance!;
  }

  PackageInfo? _packageInfo;
  DeviceInfoPlugin? deviceInfo;

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;

  DeviceInfoService._init() {
    PackageInfo.fromPlatform().then((value) => _packageInfo = value);
    deviceInfo = DeviceInfoPlugin();
    Logger.instance.log("DEVICE INFO :: DeviceInfoPlugin initialized");
    if (isAndroid) {
      Logger.instance.log("DEVICE INFO :: Platform is Android");
      deviceInfo!.androidInfo.then((value) => androidInfo = value);
    } else if (isIOS) {
      Logger.instance.log("DEVICE INFO :: Platform is IOS");
      deviceInfo!.iosInfo.then((value) => iosInfo = value);
    }

    /* Language Setter */

    /*  SharedPreferencesService.instance
        .getString(key: SharedPreferenceEnum.languageSharedPrefKey.toString(), defaultValue: )
        .then((value) async {
      _deviceLanguage = value ?? 'en';
      await ;
    }); */
  }

  bool get isAndroid => Platform.isAndroid;
  bool get isIOS => Platform.isIOS;

  /*  Package Info */
  String get appVersion => _packageInfo?.version ?? '0.0.0';
  String get appBuild => _packageInfo?.buildNumber ?? '0';

  Map<String, dynamic> packageToJson() => {'app_version': appVersion, 'app_build': appBuild};

  /*  Device Info */

  String get deviceManufacture {
    if (isAndroid) {
      return androidInfo!.manufacturer;
    } else if (isIOS) {
      return "Apple";
    } else {
      return 'Unknown';
    }
  }

  String get deviceModel {
    if (isAndroid) {
      return androidInfo!.model;
    } else if (isIOS) {
      return iosInfo!.utsname.machine.replaceAll(",", ".");
    } else {
      return 'Unknown';
    }
  }

  String get deviceIdentifier {
    if (isAndroid) {
      return androidInfo!.fingerprint;
    } else if (isIOS) {
      return iosInfo!.identifierForVendor ?? "Unknown";
    } else {
      return 'Unknown';
    }
  }

  final String _deviceLanguage = Platform.localeName.split('_')[0];

  /* void setLanguage(String language) => _deviceLanguage = language; */

  String get deviceLanguage {
    switch (_deviceLanguage) {
      case 'en':
        return 'en';
      case 'tr':
        return 'tr';
      default:
        return 'en';
    }
  }

  String? get systemVersion {
    if (isAndroid) {
      return androidInfo!.version.release;
    } else if (isIOS) {
      return iosInfo!.systemVersion;
    } else {
      return 'Unknown';
    }
  }

  String get appPlatform => isAndroid ? 'android' : 'ios';

  Map<String, dynamic> deviceToJson() => {
        'device_manufacture': deviceManufacture,
        'device_model': deviceModel,
        'device_identifier': deviceIdentifier,
        'device_language': deviceLanguage,
        'system_version': systemVersion,
        'app_platform': appPlatform,
      };

  Map<String, dynamic> toJson() {
    return packageToJson()..addAll(deviceToJson());
  }

  @override
  String toString() {
    return 'DeviceInfo{appVersion: $appVersion, appBuild: $appBuild, deviceManufacture: $deviceManufacture, deviceModel: $deviceModel, deviceIdentifier: $deviceIdentifier, deviceLanguage: $deviceLanguage, systemVersion: $systemVersion, appPlatform: $appPlatform}';
  }
}
