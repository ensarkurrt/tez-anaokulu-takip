import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseCrashlyticsService {
  static FirebaseCrashlyticsService? _instance;
  static FirebaseCrashlyticsService get instance {
    if (_instance != null) return _instance!;
    _instance = FirebaseCrashlyticsService._init();
    return _instance!;
  }

  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;

  FirebaseCrashlyticsService._init() {
    FlutterError.onError = (errorDetails) => FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
