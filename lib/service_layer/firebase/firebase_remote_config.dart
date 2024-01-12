import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:kindergarden_mobile/service_layer/localization/localization.dart';

import '../logger/logger.dart';

class FirebaseRemoteConfigService {
  static FirebaseRemoteConfigService? _instance;
  static FirebaseRemoteConfigService get instance {
    if (_instance != null) return _instance!;
    _instance = FirebaseRemoteConfigService._init();
    return _instance!;
  }

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  FirebaseRemoteConfigService._init() {
    if (kDebugMode) {
      _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: _minimumFetchInterval,
        ),
      );
    }
    /* fetchAndActivate(); */
  }

  final Duration _minimumFetchInterval = kDebugMode ? const Duration(minutes: 5) : const Duration(hours: 12);

  String getString(String key, {bool locale = true}) => _remoteConfig.getString(key + (locale ? '_${LocalizationService.include.language}' : ''));
  bool getBool(String key, {bool locale = true}) => _remoteConfig.getBool(key + (locale ? '_${LocalizationService.include.language}' : ''));
  int getInt(String key, {bool locale = true}) => _remoteConfig.getInt(key + (locale ? '_${LocalizationService.include.language}' : ''));
  double getDouble(String key, {bool locale = true}) => _remoteConfig.getDouble(key + (locale ? '_${LocalizationService.include.language}' : ''));

  List<T> getList<T>(String key, {bool locale = true}) =>
      _remoteConfig.getString(key + (locale ? '_${LocalizationService.include.language}' : '')).split(',').map((e) => e as T).toList();

  Future<bool> fetchAndActivate() async {
    if (kDebugMode) {
      Logger.instance.log('Remaining Time : ${_minimumFetchInterval.inMinutes - diffDurationDebug} minutes');
    } else {
      Logger.instance.log('Remaining Time : ${_minimumFetchInterval.inHours - diffDurationRelease} hours');
    }

    if (isFetchTime) {
      bool updatedFetch = await _remoteConfig.fetchAndActivate();
      if (updatedFetch) {
        Logger.instance.log('The config is updated..');
      } else {
        Logger.instance.log('The config is not updated..');
        return await fetchAndActivate();
      }
      return updatedFetch;
    }

    return true; /* else {
      _remoteConfig.activate();
      Logger.instance.log('The config is activated..');
      return true;
    } */
  }

  int get diffDurationDebug => DateTime.now().difference(_remoteConfig.lastFetchTime).inMinutes;
  int get diffDurationRelease => DateTime.now().difference(_remoteConfig.lastFetchTime).inHours;

  bool get isFetchTime => kDebugMode ? diffDurationDebug > _minimumFetchInterval.inMinutes : diffDurationRelease > _minimumFetchInterval.inHours;
}
