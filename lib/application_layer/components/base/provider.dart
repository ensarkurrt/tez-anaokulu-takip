import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/localization/localization.dart';
import 'package:kindergarden_mobile/service_layer/providers/connection_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/theme/theme_management.dart';
import 'package:provider/provider.dart';

import '../../../service_layer/providers/state_management.dart';

class Providers {
  final Widget child;

  Providers({required this.child});

  Widget include() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateManagement>(create: (_) => StateManagement.include),
        ChangeNotifierProvider<ConnectionManagement>(create: (_) => ConnectionManagement.include),
        ChangeNotifierProvider<ThemeManagement>(create: (_) => ThemeManagement.include),
        ChangeNotifierProvider<LocalizationService>(create: (_) => LocalizationService.include),
        ChangeNotifierProvider<SessionManagement>(create: (_) => SessionManagement.include),
      ],
      child: child,
    );
  }
}
