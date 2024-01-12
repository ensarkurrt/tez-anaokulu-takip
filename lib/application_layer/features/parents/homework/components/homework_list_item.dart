import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/list_card/list_card.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/homework/homework_detail.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/homework_model.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class HomeworkListItem extends StatefulWidget {
  final HomeWork homework;
  final Function()? onBack;
  const HomeworkListItem({Key? key, required this.homework, this.onBack}) : super(key: key);

  @override
  State<HomeworkListItem> createState() => _HomeworkListItemState();
}

class _HomeworkListItemState extends State<HomeworkListItem> {
  Color get iconColor => widget.homework.isDone ? Colors.green : Colors.red;
  IconPathEnums get selectedIcon => widget.homework.isDone ? IconPathEnums.confirm : IconPathEnums.circleXmark;
  @override
  Widget build(BuildContext context) {
    return ListCard(
      onTap: () async {
        await context.navigateTo(HomeworkDetail(
          homework: widget.homework,
        ));

        if (widget.onBack != null) {
          widget.onBack!();
        }
      },
      icon: selectedIcon.widget(
        color: iconColor,
        height: context.height * 0.05,
        width: context.width * 0.06,
      ),
      body: Expanded(child: TextColumn(context)),
    );
  }

  Widget TextColumn(BuildContext context) {
    return VerticalColumnWithSpace(
      factor: 0.005,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.homework.title, style: context.fonts.title.copyWith(color: context.textColors.title)),
        Text(widget.homework.content, style: context.fonts.small.copyWith(color: context.textColors.description, fontWeight: FontWeight.w500)),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Metni sola hizala
              children: [Text('Detayları Göster', style: context.fonts.small.copyWith(color: context.textColors.error, fontWeight: FontWeight.bold))],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.homework.parseDate, style: context.fonts.small.copyWith(color: context.textColors.filledInputForm)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
