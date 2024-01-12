import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/list_card/list_card.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

import '../../../../../tools/enums/icon_path_enums.dart';

class DocumentListItem extends StatelessWidget {
  const DocumentListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListCard(
      icon: IconPathEnums.acrobat.widget(),
      body: listItemBody(context),
    );
  }

  Expanded listItemBody(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Genel Kurallar.pdf",
            style: context.fonts.title.copyWith(color: context.textColors.title),
          ),
          context.addVerticalSpace(0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Yükleme Tarihi: 02.02.2023",
                style: context.fonts.small.copyWith(color: context.textColors.description),
              ),
            ],
          )
        ],
      ),
    );
  }
}
