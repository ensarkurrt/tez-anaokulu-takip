import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class DocumentLinkText extends StatefulWidget {
  const DocumentLinkText({super.key});

  @override
  State<DocumentLinkText> createState() => _DocumentLinkTextState();
}

class _DocumentLinkTextState extends State<DocumentLinkText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Örnek Çizim', style: context.fonts.smallBodyUnderline.copyWith(color: context.textColors.error)),
        context.addHorizontalSpace(0.01),
        IconPathEnums.acrobat.widget(
          height: context.height * 0.015,
          width: context.height * 0.015,
        ),
      ],
    );
  }
}
