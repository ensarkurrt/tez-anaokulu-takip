import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/list_card/list_card.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

import '../../../../../tools/enums/icon_path_enums.dart';

class PaymentsListItem extends StatelessWidget {
  const PaymentsListItem({super.key, required this.months, required this.verified});

  final String? months;
  final bool? verified;

  @override
  Widget build(BuildContext context) {
    return ListCard(
      icon: (verified!) ? IconPathEnums.greenVerified.widget() : IconPathEnums.redDenied.widget(),
      body: listItemBody(context),
    );
  }

  Widget listItemBody(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                months!,
                style: context.fonts.title.copyWith(color: context.textColors.filledInputForm),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Yükleme Tarihi: 02.02.2023",
                    style: context.fonts.small.copyWith(color: context.textColors.deactiveInput),
                  ),
                ],
              )
            ],
          ),
          Text(
            "1200₺",
            style: context.fonts.title.copyWith(color: context.textColors.filledInputForm),
          )
        ],
      ),
    );
  }
}
