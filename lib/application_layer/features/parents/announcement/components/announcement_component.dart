import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/announcement/announcement_detail.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/announcement_model.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class CustomAnnouncementComponent extends StatefulWidget {
  final Announcement announcement;
  final Function? onBack;
  const CustomAnnouncementComponent({super.key, required this.announcement, this.onBack});

  @override
  State<CustomAnnouncementComponent> createState() => _CustomAnnouncementComponentState();
}

class _CustomAnnouncementComponentState extends State<CustomAnnouncementComponent> {
  IconPathEnums announcementIcon = IconPathEnums.announcement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.navigateTo(AnnouncementDetailView(
          announcement: widget.announcement,
        ));

        if (widget.onBack != null) {
          widget.onBack!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: context.themeColors.main,
          borderRadius: BorderRadius.circular(10),
        ),
        child: VerticalColumnWithSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          factor: 0.005,
          children: [
            Text(
              widget.announcement.title.substring(0, widget.announcement.title.length >= 18 ? 18 : widget.announcement.title.length) +
                  (widget.announcement.title.length >= 18 ? '...' : ''),
              style: context.fonts.title.copyWith(color: context.textColors.title),
            ),
            Text(
              widget.announcement.content.substring(0, widget.announcement.content.length >= 50 ? 50 : widget.announcement.content.length),
              style: context.fonts.small.copyWith(color: context.textColors.description, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text(
                  'Ayrıntıları Göster',
                  style: context.fonts.small.copyWith(color: context.textColors.error, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  widget.announcement.parseDate,
                  style: context.fonts.small.copyWith(color: context.textColors.filledInputForm),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
