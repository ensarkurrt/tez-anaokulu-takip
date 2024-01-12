import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/classes/add_class_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/class_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';
import 'package:provider/provider.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Sınıflar",
          ),
        ),
        floatingActionButton: SessionManagement.include.isSchool
            ? FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddClassView()));
                },
                child: const Icon(Icons.add),
              )
            : null,
        body: PageLayout(
            child: VerticalColumnWithSpace(children: [
          ...context
              .watch<SessionManagement>()
              .school
              .classes!
              .map(
                (ClassModel item) => classTile(item),
              )
              .toList()
        ])),
      ),
    );
  }

  Widget classTile(ClassModel item) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: ((builder) => Options(item))),
      child: Container(
        width: double.infinity,
        padding: PaddingEnums.cardPadding.all(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.themeColors.main,
        ),
        child: Row(children: [
          Text(
            item.name,
            style: context.fonts.title.copyWith(color: Colors.black),
          ),
          const Spacer(),
          Text(
            item.parseDate,
            style: context.fonts.body.copyWith(color: Colors.black),
          ),
        ]),
      ),
    );
  }

  Widget Options(ClassModel item) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(context.height * 0.02), // Köşe radiusunu ayarla
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      margin: EdgeInsets.all(context.height * 0.02),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(context.height * 0.02),
            child: Text(
              "İşlemler",
              style: context.fonts.title.copyWith(color: context.textColors.filledInputForm),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          context.addVerticalSpace(0.02),
          button("Sil", () async {
            Navigator.pop(context);
            StateManagement.include.changeStateBusy();
            await supabase.from('classes').delete().eq('id', item.id);
            await SessionManagement.include.updateSession();

            Future.delayed(const Duration(seconds: 1), () {
              StateManagement.include.changeStateIdle();
              context.showSnackBar(text: "Sınıf silindi.");
            });
          }, color: Colors.red)
        ],
      ),
    );
  }

  Widget button(String title, Function onTap, {Color? color}) {
    return GestureDetector(
      onTap: () async => await onTap(),
      child: Text(
        title,
        style: context.fonts.body.copyWith(color: color ?? context.textColors.filledInputForm),
        textAlign: TextAlign.center,
      ),
    );
  }
}
