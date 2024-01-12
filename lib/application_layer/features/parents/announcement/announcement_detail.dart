// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/snack_bar/base_snack_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/announcement_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class AnnouncementDetailView extends StatefulWidget {
  final Announcement announcement;
  const AnnouncementDetailView({super.key, required this.announcement});

  @override
  State<AnnouncementDetailView> createState() => _AnnouncementDetailViewState();
}

TextStyle myTextStyle = const TextStyle();

IconPathEnums pdfIcon = IconPathEnums.pdf;

class _AnnouncementDetailViewState extends State<AnnouncementDetailView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Duyuru Detayı",
          ),
        ),
        body: Padding(
          padding: PaddingEnums.pagePadding.all(context),
          child: VerticalColumnWithSpace(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            factor: 0.015,
            children: [
              Text(widget.announcement.title, style: context.fonts.title.copyWith(color: context.textColors.title)),
              Text(widget.announcement.content, style: context.fonts.smallBody.copyWith(color: context.textColors.filledInputForm)),
              Text(widget.announcement.parseDate,
                  style: context.fonts.smallBody.copyWith(color: context.textColors.filledInputForm, fontWeight: FontWeight.bold)),
              SessionManagement.include.isStudent
                  ? const SizedBox()
                  : TMButton(
                      title: "Sil",
                      backgroundColor: Colors.red,
                      onTap: () async {
                        StateManagement.include.changeStateBusy();
                        await supabase.from('announcements').delete().eq('id', widget.announcement.id);
                        StateManagement.include.changeStateIdle();
                        Navigator.pop(context);
                        context.showSnackBar(text: "Duyuru Silindi", alertType: CustomAlertType.Success);
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

Text textMethod(text) => Text(text, style: myTextStyle);
