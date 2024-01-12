// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/snack_bar/base_snack_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/homework_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class HomeworkDetail extends StatefulWidget {
  final HomeWork homework;
  const HomeworkDetail({super.key, required this.homework});

  @override
  State<HomeworkDetail> createState() => _HomeworkDetailState();
}

class _HomeworkDetailState extends State<HomeworkDetail> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: context.materialAppBarSize, child: const MaterialCustomAppBar(title: 'Ödevler')),
        backgroundColor: Colors.transparent,
        body: PageLayout(
          child: Padding(
            padding: PaddingEnums.pagePadding.horizontal(context),
            child: TextColumn(context),
          ),
        ),
      ),
    );
  }

  Column TextColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.homework.title, style: context.fonts.title.copyWith(color: context.textColors.title)),
        context.addVerticalSpace(context.height * 0.000015),
        Text(widget.homework.content, style: context.fonts.small.copyWith(color: context.textColors.filledInputForm)),
        context.addVerticalSpace(context.height * 0.00005),
        Text(widget.homework.parseDate, style: context.fonts.smallBody.copyWith(color: context.textColors.title)),
        context.addVerticalSpace(context.height * 0.00005),
        SessionManagement.include.isStudent
            ? TMButton(
                isActive: !widget.homework.isDone,
                title: "Ödevi Yaptım",
                onTap: () async {
                  await supabase.from('homework_process').insert([
                    {
                      'homework_id': widget.homework.id,
                      'student_id': SessionManagement.include.student.id,
                    }
                  ]);

                  setState(() {
                    widget.homework.isDone = true;
                  });
                })
            : TMButton(
                title: "Sil",
                onTap: () async {
                  StateManagement.include.changeStateBusy();
                  await supabase.from('homeworks').delete().eq('id', widget.homework.id);
                  StateManagement.include.changeStateIdle();
                  Navigator.pop(context);
                  context.showSnackBar(text: "Ödev Silindi", alertType: CustomAlertType.Success);
                },
                backgroundColor: Colors.red,
              ),
        /*  Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Ensar KURT",
            style: context.fonts.smallBody.copyWith(color: context.textColors.filledInputForm),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Sınıf Öğremeni",
            style: context.fonts.smallBody.copyWith(color: context.textColors.title),
          ),
        ),
        context.addVerticalSpace(context.height * 0.00004),
        Text("Ekler:", style: context.fonts.smallBody.copyWith(color: context.textColors.filledInputForm)),
        context.addVerticalSpace(context.height * 0.000001),
        const DocumentLinkText(),
        const DocumentLinkText(), */
      ],
    );
  }
}
