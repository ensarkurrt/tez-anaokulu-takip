import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class SettingCardItemModel {
  final String title;
  final Function onTap;

  SettingCardItemModel({required this.title, required this.onTap});
}

class SettingCardComponent extends StatefulWidget {
  final List<SettingCardItemModel> items;
  final String title;
  const SettingCardComponent({super.key, required this.items, required this.title});

  @override
  State<SettingCardComponent> createState() => _SettingCardComponentState();
}

class _SettingCardComponentState extends State<SettingCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
          context.addVerticalSpace(0.01),
          Container(
            width: context.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.height * 1 * 0.015),
              color: context.themeColors.main,
            ),
            child: Column(
              children: [
                for (var item in widget.items) buildListTile(item.title, item.onTap),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(String title, Function onTap) {
    return ListTile(
      title: Text(title, style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
      trailing: IconPathEnums.next.widget(height: context.height * 0.02, width: context.width * 0.02, color: context.textColors.filledInputForm),
      onTap: () => onTap(),
    );
  }
}
