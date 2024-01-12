import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';

class FirebaseCloudMessagingService {
  static FirebaseCloudMessagingService? _instance;
  static FirebaseCloudMessagingService get instance {
    if (_instance != null) return _instance!;
    _instance = FirebaseCloudMessagingService._init();
    return _instance!;
  }

/*  */
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? token;

  FirebaseCloudMessagingService._init() {
    _fcm.onTokenRefresh.listen((event) => token = event);
    checkPermission();
  }

  Future<bool> checkPermission() async {
    NotificationSettings notificationSettings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    token = await _fcm.getToken();
    Logger.instance.log("FCM TOKEN :: $token");

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    return notificationSettings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
