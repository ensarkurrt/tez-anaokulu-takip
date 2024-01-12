// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';

class AddAnnouncementView extends StatefulWidget {
  const AddAnnouncementView({super.key});

  @override
  State<AddAnnouncementView> createState() => _AddAnnouncementViewState();
}

class _AddAnnouncementViewState extends State<AddAnnouncementView> {
  String? title, content;
  int? selectedClass;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Duyuru Ekle",
          ),
        ),
        body: PageLayout(
          child: Form(
            key: _formKey,
            child: VerticalColumnWithSpace(children: [
              const InfoText(text: "Sınıfınız için bir duyuru ekleyin."),
              InputField(
                label: "Başlık",
                required: true,
                onChanged: (String value) => setState(() => title = value),
              ),
              InputField(
                label: "İçerik",
                required: true,
                onChanged: (String value) => setState(() => content = value),
              ),
              SizedBox(
                width: double.infinity,
                child: ClassesDropdown(onChanged: (int value) {
                  setState(() {
                    selectedClass = value;
                  });
                }),
              ),
              TMButton(
                  title: "Ekle",
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    StateManagement.include.changeStateBusy();

                    await supabase.from('announcements').insert([
                      {
                        'title': title,
                        'content': content,
                        'class_id': selectedClass,
                      }
                    ]);
                    StateManagement.include.changeStateIdle();
                    context.showSnackBar(text: "Duyuru eklendi.");
                    Navigator.pop(context);
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
