import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/reports/components/reports_list_item.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Raporlar",
          ),
        ),
        body: const PageLayout(
          child: VerticalListWithSpace(
            shrinkWrap: true,
            factor: 0.015,
            children: [
              InfoText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nibh ut tortor aliquam aliquet. "),
              ReportsListItem(),
              ReportsListItem(),
              ReportsListItem(),
              ReportsListItem(),
            ],
          ),
        ),
      ),
    );
  }
}
