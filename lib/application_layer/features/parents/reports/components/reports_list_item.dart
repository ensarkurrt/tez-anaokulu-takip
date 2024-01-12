import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/list_card/list_card.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/end_of_day_report/end_of_day_report_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/image_path_enums.dart';

class ReportsListItem extends StatelessWidget {
  const ReportsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListCard(
      onTap: () => context.navigateTo(const EndOfDayReportView()),
      body: listItemMiddlePart(context),
      icon: ImagePathEnums.profileAvatar.widget(),
    );
  }

  Expanded listItemMiddlePart(BuildContext context) {
    return Expanded(
      child: VerticalColumnWithSpace(
        factor: 0.01,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "04.05.2024 Gün Sonu Raporu",
            style: context.fonts.body.copyWith(color: context.textColors.filledInputForm, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Neşeli Hissediyor",
                style: context.fonts.smallBody.copyWith(color: context.textColors.deactiveInput),
              ),
            ],
          )
        ],
      ),
    );
  }
}
