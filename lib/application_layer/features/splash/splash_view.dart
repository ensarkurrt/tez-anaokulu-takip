// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/redirective_page.dart';
import 'package:kindergarden_mobile/application_layer/components/indicators/circle_indicator.dart';
import 'package:kindergarden_mobile/application_layer/features/auth/login/login_view.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
    super.initState();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      if (SessionManagement.include.isSchool) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RedirectivePage()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RedirectivePage()), (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginView()), (route) => false);
    }
  }

  Future initialize() async {
    Future.delayed(const Duration(seconds: 3), () async {
      Logger.instance.log('SplashView ::: initializing');
      await SessionManagement.include.updateSession();
      _redirect();
      /*  if (ConnectionManagement.include.state == ConnectState.Connected) {
        bool updated = await FirebaseRemoteConfigService.instance.fetchAndActivate();
        if (updated) {
          await LocalizationService.include.init();
          if (VersionService.instance.isForceUpdate) {
            /* Hard update dialog, and is required */
            await showDialog(context: context, barrierDismissible: false, builder: (builder) => const ForceUpdatePopUp());
          } else if (VersionService.instance.isSoftUpdate) {
            /* Soft update dialog, and is no required */
            await showDialog(context: context, builder: (builder) => const SoftUpdatePopUp());
          }

          /* await TextToSpeechService.include.init(); */
          await ThemeManagement.include.syncTheme();

          Logger.instance.log('SplashView ::: initialized');
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const OnBoardingView()), (route) => false);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RedirectivePage()), (route) => false);
        } else {
          initialize();
        }
      } else {
        initialize();
      } */
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RedirectivePage()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircleIndicator()),
      ),
    );
  }
}
