import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/home/home_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/home/home_view.dart' as school;
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:provider/provider.dart';

class RedirectivePage extends StatefulWidget {
  const RedirectivePage({
    Key? key,
    /* required this.currentTab,
    required this.selectedTabItem,
    required this.navigatorKeys, */
  }) : super(key: key);

  @override
  State<RedirectivePage> createState() => _RedirectivePageState();
}

class _RedirectivePageState extends State<RedirectivePage> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.themeColors.background,
        body: context.watch<SessionManagement>().isSchool ? const school.HomeView() : const HomeView(),
      ),
    );
  }
}
