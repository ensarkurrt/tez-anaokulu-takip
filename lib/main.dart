import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kindergarden_mobile/application_layer/components/base/provider.dart';
import 'package:kindergarden_mobile/application_layer/features/splash/splash_view.dart';
import 'package:kindergarden_mobile/service_layer/device_info/device_info.dart';
import 'package:kindergarden_mobile/service_layer/hive/hive_database_manager.dart';
import 'package:kindergarden_mobile/service_layer/network/connectivity_manager.dart';
import 'package:kindergarden_mobile/service_layer/shake/shake_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* GoogleAdManager.instance; */
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  HttpOverrides.global = MyHttpOverrides();
  ShakeManager.instance;
  DeviceInfoService.instance;
  ConnectivityManager.instance;
  await HiveDatabaseManager().start();

  /* for (var item in BannerAds.values) {
    await GoogleAdManager.instance.loadBannerAd(replacement: item.name);
  } */

  await Supabase.initialize(
    url: 'https://vtvwvgzehoehoriebfyk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0dnd2Z3plaG9laG9yaWViZnlrIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNDc5NDcwOSwiZXhwIjoyMDIwMzcwNzA5fQ.zs0Wqrfh3DVepjrQMcM9_vBsp9-oHjuVdz6ygHHwliA',
  );

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

final supabase = Supabase.instance.client;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizerUtil.setScreenSize(constraints, orientation);
        return Providers(
          child: MaterialApp(
            title: 'Kindergarden App',
            navigatorObservers: [ChuckerFlutter.navigatorObserver],
            theme: ThemeData(
              fontFamily: 'Poppins',
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color(0xFF2A663B),
                selectionColor: Color(0xFF2A663B),
                selectionHandleColor: Color(0xFF2A663B),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          ),
        ).include();
      });
    });
  }
}
