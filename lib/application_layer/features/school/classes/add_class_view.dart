// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/application_layer/components/snack_bar/base_snack_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';

class AddClassView extends StatefulWidget {
  const AddClassView({super.key});

  @override
  State<AddClassView> createState() => _AddClassViewState();
}

class _AddClassViewState extends State<AddClassView> {
  String? className;
  bool _isAdding = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Sınıf Ekle",
          ),
        ),
        body: PageLayout(
          child: Form(
            key: _formKey,
            child: VerticalColumnWithSpace(children: [
              const InfoText(text: "Bu sayfa üzerinden okulunuza sınıf ekleyebilirsiniz."),
              InputField(
                label: "Sınıf Adı",
                onChanged: (p0) => setState(() => className = p0),
              ),
              TMButton(
                title: _isAdding ? "Ekleniyor! Lütfen bekleyin..." : "Ekle",
                isActive: !_isAdding,
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  StateManagement.include.changeStateBusy();
                  setState(() => _isAdding = true);
                  await supabase.from('classes').insert([
                    {
                      'name': className,
                      'school_id': SessionManagement.include.school.id,
                    }
                  ]);

                  await SessionManagement.include.updateSession();

                  StateManagement.include.changeStateIdle();
                  context.showSnackBar(text: "Sınıf başarıyla eklendi.", alertType: CustomAlertType.Success);
                  Navigator.pop(context);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
