import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:kindergarden_mobile/service_layer/firebase/firebase_cloud_messaging.dart';
import 'package:kindergarden_mobile/service_layer/firebase/firebase_remote_config.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:kindergarden_mobile/service_layer/providers/connection_management.dart';

import 'firebase_analytics.dart';
import 'firebase_crashlytics.dart';
import 'firebase_options.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance {
    if (_instance != null) return _instance!;
    _instance = FirebaseService._init();
    return _instance!;
  }

  FirebaseService._init();

  Future initAllServices() async {
    if (ConnectionManagement.include.state != ConnectState.Connected) return;
    Logger.instance.log('FirebaseService ::: Initializing all services');
    if (Firebase.apps.isEmpty) {
      Logger.instance.log('FirebaseService ::: Initializing Firebase');
      await Firebase.initializeApp(name: 'best-ai', options: DefaultFirebaseOptions.currentPlatform);
    }

    /* Remote Config Service Initialization */
    FirebaseRemoteConfigService.instance;

    await FirebaseCloudMessagingService.instance.checkPermission();

    /* Analytics Service Initialization */
    FirebaseAnalyticsService.instance;

    if (!kDebugMode) {
      /* Crashlytics Service Initialization */
      FirebaseCrashlyticsService.instance;
      /* Performance Service Initialization */
      FirebasePerformance.instance;
    }
  }
}
