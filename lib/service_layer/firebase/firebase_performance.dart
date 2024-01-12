import 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformanceService {
  static FirebasePerformanceService? _instance;
  static FirebasePerformanceService get instance {
    if (_instance != null) return _instance!;
    _instance = FirebasePerformanceService._init();
    return _instance!;
  }

  /* Performance Instance getter  */
  FirebasePerformance get performance => FirebasePerformance.instance;

  FirebasePerformanceService._init() {
    FirebasePerformance.instance;
  }
}
