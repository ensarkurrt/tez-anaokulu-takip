import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          shape: const BeveledRectangleBorder(side: BorderSide.none),
          title: const Text("Kahvaltı"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text("1 yumurta 2 salatalık yedi"),
            )
          ],
        ),
        ExpansionTile(
          shape: const BeveledRectangleBorder(side: BorderSide.none),
          title: const Text("Kahvaltı"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text("1 yumurta 2 salatalık yedi"),
            )
          ],
        ),
        ExpansionTile(
          shape: const BeveledRectangleBorder(side: BorderSide.none),
          title: const Text("Kahvaltı"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
              IconPathEnums.confirm.widget(width: 30, height: 30),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text("1 yumurta 2 salatalık yedi"),
            )
          ],
        )
      ],
    );
  }
}