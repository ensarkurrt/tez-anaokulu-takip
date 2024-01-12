import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:kindergarden_mobile/tools/enums/radius_enums.dart';

class InfoText extends StatefulWidget {
  final String text;

  const InfoText({super.key, required this.text});

  @override
  State<InfoText> createState() => _InfoTextState();
}

class _InfoTextState extends State<InfoText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: context.themeColors.main,
        borderRadius: RadiusEnums.general.all(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.height * 0.03,
            width: context.height * 0.03,
            child: Center(
              child: IconPathEnums.info.widget(color: context.textColors.filledInputForm),
            ),
          ),
          context.addHorizontalSpace(0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.text, style: context.fonts.smallBody.copyWith(color: context.textColors.filledInputForm)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
