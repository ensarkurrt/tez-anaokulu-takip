import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/general_information/components/communication_table.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class CommunicationSettingsView extends StatefulWidget {
  const CommunicationSettingsView({super.key});

  @override
  State<CommunicationSettingsView> createState() => _CommunicationSettingsViewState();
}

class _CommunicationSettingsViewState extends State<CommunicationSettingsView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.appBarSize,
          child: const MaterialCustomAppBar(
            title: "İletişim Bilgileri",
          ),
        ),
        body: const PageLayout(
          // TODO :: review this
          child: Column(
            children: [
              CommunicationTable(),
            ],
          ),
        ),
      ),
    );
  }
}
