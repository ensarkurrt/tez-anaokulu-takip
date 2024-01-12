import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/app_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/end_of_day_report/components/bottom_section.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/end_of_day_report/components/middle_section.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/end_of_day_report/components/top_section.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class EndOfDayReportView extends StatelessWidget {
  const EndOfDayReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.height * 0.07),
        child: const CustomAppBar(
          title: "Gün Sonu Raporu",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            const TopSection(),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: context.height * (2 / 100),
            ),
            const MiddleSection(),
            SizedBox(
              height: context.height * (3 / 100),
            ),
            const BottomSection()
          ],
        ),
      ),
    ));
  }
}
