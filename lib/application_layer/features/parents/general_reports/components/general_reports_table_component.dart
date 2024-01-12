import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/general_report_item_model.dart';

class GeneralReportTableComponents extends StatefulWidget {
  final List<GeneralReportItemModel> items;
  const GeneralReportTableComponents({super.key, required this.items});

  @override
  State<GeneralReportTableComponents> createState() =>
      _GeneralReportTableComponentsState();
}

class _GeneralReportTableComponentsState
    extends State<GeneralReportTableComponents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ], borderRadius: BorderRadius.circular(25), color: Colors.grey[200]),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
                color: const Color(0xffFF9500).withOpacity(0.8),
              ),
              height: context.height * 0.04,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabTitle("Puan"),
                  TabTitle("Aktivite"),
                  TabTitle("Kayıt Sayısı"),
                ],
              ),
            ),
            Column(children: widget.items.map((e) => ListRow(e)).toList())
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ListRow(GeneralReportItemModel item) {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Center(
                  child: Text(item.point,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 32, 32, 32),
                        fontWeight: FontWeight.w600,
                      )))),
          Expanded(
              child: Center(
                  child: Text(item.title,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 32, 32, 32),
                        fontWeight: FontWeight.w600,
                      )))),
          Expanded(
              child: Center(
                  child: Text("(${item.recordCount} Kayıt)",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 122, 122, 122),
                        fontWeight: FontWeight.w600,
                      )))),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded TabTitle(String title) {
    return Expanded(
        child: Center(
      child: Text(title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
    ));
  }
}
