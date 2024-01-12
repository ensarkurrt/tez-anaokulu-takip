import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/general_reports/components/default_tab_controller.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class GeneralReportView extends StatefulWidget {
  const GeneralReportView({super.key});

  @override
  State<GeneralReportView> createState() => _GeneralReportViewState();
}

class _GeneralReportViewState extends State<GeneralReportView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Genel Durum",
          ),
        ),
        body: const PageLayout(
          child: VerticalColumnWithSpace(
            factor: 0.015,
            children: [
              InfoText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nibh ut tortor aliquam aliquet. "),
              TabBarItem(),
            ],
          ),
        ),
      ),
    );
  }
}
