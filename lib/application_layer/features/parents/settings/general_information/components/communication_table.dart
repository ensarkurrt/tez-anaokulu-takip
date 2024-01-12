import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class CommunicationTable extends StatefulWidget {
  const CommunicationTable({super.key});

  @override
  State<CommunicationTable> createState() => _CommunicationTableState();
}

class _CommunicationTableState extends State<CommunicationTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height * 0.015,
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.height * 0.04,
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(context.height * 0.02),
                      topRight: Radius.circular(context.height * 0.02)),
                  color: const Color(0xFFFF9F0A)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Telefon Rehberi',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            ItemTable(context),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Container ItemTable(BuildContext context) {
  return Container(
    height: context.height * 0.26,
    width: context.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(context.height * 0.02),
            bottomRight: Radius.circular(context.height * 0.02)),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 4),
              color: Color.fromARGB(136, 109, 109, 109))
        ]),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(context.height * 0.02),
          child: Row(
            children: [
              IconPathEnums.school.widget(height: 30, width: 30),
              TabTitle("Okul Güvenliği"),
              TabTitle("0555-555-5555"),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.all(context.height * 0.02),
          child: Row(
            children: [
              IconPathEnums.male.widget(height: 30, width: 30),
              TabTitle("Rehber Öğretmeni"),
              TabTitle("0555-555-5555"),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.all(context.height * 0.02),
          child: Row(
            children: [
              IconPathEnums.info.widget(height: 30, width: 30),
              context.addHorizontalSpace(0.035),
              const Expanded(
                  child: Text(
                'Lütfen sadece önemli konular için iletişim kurunuz.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                ),
              ))
            ],
          ),
        )
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Expanded TabTitle(String title) {
  return Expanded(
      child: Center(
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w600,
      ),
    ),
  ));
}
