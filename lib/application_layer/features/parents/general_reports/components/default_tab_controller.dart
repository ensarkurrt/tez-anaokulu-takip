import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/general_reports/components/general_reports_table_component.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/general_report_item_model.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class TabBarItem extends StatefulWidget {
  const TabBarItem({super.key});

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> {
  final List<GeneralReportItemModel> _lastOneMounth = [
    GeneralReportItemModel(
      title: "Devam",
      point: "85 Gün",
      recordCount: 5,
    ),
    GeneralReportItemModel(
      title: "Devamsızlık",
      point: "3 Gün",
      recordCount: 1,
    ),
    GeneralReportItemModel(
      title: "Kahvaltı",
      point: "4.5/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "Öğle Yemeği",
      point: "4.1/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "İkindi Yemeği",
      point: "4.7/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "İkindi Yemeği",
      point: "4.7/5",
      recordCount: 3,
    ),
  ];
  final List<GeneralReportItemModel> _lastThreeMounth = [
    GeneralReportItemModel(
      title: "Devam",
      point: "85 Gün",
      recordCount: 5,
    ),
    GeneralReportItemModel(
      title: "Devamsızlık",
      point: "3 Gün",
      recordCount: 1,
    ),
    GeneralReportItemModel(
      title: "Kahvaltı",
      point: "4.5/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "Öğle Yemeği",
      point: "4.1/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "İkindi Yemeği",
      point: "4.7/5",
      recordCount: 3,
    ),
  ];
  final List<GeneralReportItemModel> _lastSixMounth = [
    GeneralReportItemModel(
      title: "Devam",
      point: "85 Gün",
      recordCount: 5,
    ),
    GeneralReportItemModel(
      title: "Devamsızlık",
      point: "3 Gün",
      recordCount: 1,
    ),
    GeneralReportItemModel(
      title: "Kahvaltı",
      point: "4.5/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "Öğle Yemeği",
      point: "4.1/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "İkindi Yemeği",
      point: "4.7/5",
      recordCount: 3,
    ),
  ];
  final List<GeneralReportItemModel> _lastYear = [
    GeneralReportItemModel(
      title: "Devam",
      point: "85 Gün",
      recordCount: 5,
    ),
    GeneralReportItemModel(
      title: "Devamsızlık",
      point: "3 Gün",
      recordCount: 1,
    ),
    GeneralReportItemModel(
      title: "Kahvaltı",
      point: "4.5/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "Öğle Yemeği",
      point: "4.1/5",
      recordCount: 3,
    ),
    GeneralReportItemModel(
      title: "İkindi Yemeği",
      point: "4.7/5",
      recordCount: 3,
    ),
  ];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            unselectedLabelColor: context.textColors.deactiveInput,
            labelColor: context.textColors.filledInputForm,
            indicatorColor: context.themeColors.accent,
            indicatorWeight: context.height * 0.002,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: context.fonts.body,
            tabs: [
              TabWidget("Son 1 Ay"),
              TabWidget("Son 3 Ay"),
              TabWidget("Son 6 Ay"),
              TabWidget("Son 1 Yıl"),
            ],
          ),
          Container(
            margin: PaddingEnums.pagePaddingHalf.vertical(context),
            height: context.height * 0.4,
            child: TabBarView(
              children: [
                pagebuilder(_lastOneMounth),
                pagebuilder(_lastThreeMounth),
                pagebuilder(_lastSixMounth),
                pagebuilder(_lastYear),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TabWidget(String title) {
    return Tab(
      child: Container(
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(title),
      ),
    );
  }

  Widget pagebuilder(List<GeneralReportItemModel> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: GeneralReportTableComponents(items: items),
      ),
    );
  }
}
