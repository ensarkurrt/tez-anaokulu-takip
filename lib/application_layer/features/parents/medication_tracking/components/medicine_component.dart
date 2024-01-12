import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class MedicineComponent extends StatelessWidget {
  MedicineComponent({super.key});

  IconPathEnums capsule = IconPathEnums.capsule;
  IconPathEnums pills = IconPathEnums.pills;
  IconPathEnums acrobat = IconPathEnums.acrobat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.width * 0.032, right: context.width * 0.032),
      child: Container(
        width: context.width * 0.97,
        height: context.height * 0.24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [BoxShadow(spreadRadius: 1, blurRadius: 2, offset: Offset(0, 2), color: Colors.black12)]),
        child: MedicineContainer(
          text: 'Saat 10.00',
          text2: '10.10 Alındı',
          icon: acrobat.widget(height: 30, width: 30),
        ),
      ),
    );
  }
}

class MedicineContainer extends StatelessWidget {
  MedicineContainer({super.key, required this.icon, required this.text, required this.text2});

  Widget icon;
  String text;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.addVerticalSpace(0.015),
        const Text(
          'İlaç Adı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        context.addVerticalSpace(0.017),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: context.height * 0.018),
            ),
            icon,
            Text(
              text2,
              style: TextStyle(fontSize: context.height * 0.018, color: const Color(0xFF636366)),
            ),
          ],
        ),
        context.addVerticalSpace(0.017),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: context.height * 0.018),
            ),
            icon,
            Text(
              text2,
              style: TextStyle(fontSize: context.height * 0.018, color: const Color(0xFF636366)),
            )
          ],
        ),
        context.addVerticalSpace(0.017),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: context.height * 0.018),
            ),
            icon,
            Text(
              text2,
              style: TextStyle(fontSize: context.height * 0.018, color: const Color(0xFF636366)),
            )
          ],
        ),
      ],
    );
  }
}
