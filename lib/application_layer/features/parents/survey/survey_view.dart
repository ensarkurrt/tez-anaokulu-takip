import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/table_calendar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/survey/components/Continuity.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Anketler",
          ),
        ),
        body: PageLayout(
          child: VerticalColumnWithSpace(
            factor: 0.015,
            children: [
              TableCalendarItem(
                onDayChanged: (DateTime) {},
              ),
              const InfoText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nibh ut tortor aliquam aliquet. "),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Continuity(totalCount: 3, monthly: true),
                  context.addHorizontalSpace(0.05),
                  const Continuity(totalCount: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
