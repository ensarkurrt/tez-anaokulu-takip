import 'package:firebase_analytics/firebase_analytics.dart';

import '../logger/logger.dart';

class FirebaseAnalyticsService {
  static FirebaseAnalyticsService? _instance;
  static FirebaseAnalyticsService get instance {
    if (_instance != null) return _instance!;
    _instance = FirebaseAnalyticsService._init();
    return _instance!;
  }

  /* Analytics Instance getter  */
  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

  FirebaseAnalyticsService._init() {
    FirebaseAnalytics.instance;
  }

  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    Logger.instance.log('FirebaseAnalyticsService name: $name, parameters: $parameters');
    await analytics.logEvent(name: name, parameters: parameters);
  }
}
