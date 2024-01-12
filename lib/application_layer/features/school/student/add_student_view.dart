// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  int? selectedClassId;
  String? fullName, mail, password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Öğrenci Ekle",
          ),
        ),
        body: PageLayout(
            child: Form(
          key: _formKey,
          child: VerticalColumnWithSpace(
            children: [
              SizedBox(width: context.width, child: ClassesDropdown(onChanged: (id) => setState(() => selectedClassId = id))),
              InputField(label: "Tam Adı", onChanged: (value) => setState(() => fullName = value)),
              InputField(label: "Mail Adresi", keyboardType: TextInputType.emailAddress, onChanged: (value) => setState(() => mail = value)),
              InputField(label: "Parola", obsecureText: true, onChanged: (value) => setState(() => password = value)),
              TMButton(
                title: "Kaydet",
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (selectedClassId == null) {
                    context.showSnackBar(text: "Lütfen bir sınıf seçiniz");
                    return;
                  }
                  StateManagement.include.changeStateBusy();

                  String? userId;
                  List<User> users = await supabase.auth.admin.listUsers();

                  for (var element in users) {
                    if (element.email!.contains(mail!)) {
                      userId = element.id;
                      break;
                    }
                  }

                  if (userId == null) {
                    UserResponse response = await supabase.auth.admin
                        .createUser(AdminUserAttributes(email: mail, password: password, userMetadata: {'name': fullName}, emailConfirm: true));

                    userId = response.user!.id;
                  }

                  await supabase.from('students').insert([
                    {
                      'user_id': userId,
                      'name': fullName,
                      'school_id': SessionManagement.include.school.id,
                      'class_id': selectedClassId,
                    }
                  ]);

                  StateManagement.include.changeStateIdle();
                  Navigator.pop(context);
                  context.showSnackBar(text: "Öğrenci başarıyla eklendi");
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  String generateRandomPassword() {
    int length = 6;
    String chars = 'abcdefghjkmnopqrstuvwxyzABCDEFGHKMNPQRSTUVWXYZ23456789';
    String result = '';
    for (int i = 0; i < length; i++) {
      result += chars[Random().nextInt(chars.length)];
    }
    return result;
  }
}
