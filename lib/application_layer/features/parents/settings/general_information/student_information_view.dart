import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class StudentInfoView extends StatelessWidget {
  const StudentInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.appBarSize,
          child: const MaterialCustomAppBar(
            title: "Öğrenci Bilgileri",
          ),
        ),
        body: PageLayout(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(context.height * 0.015),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.height * 0.018),
                  child: Column(
                    children: [
                      const InputField(
                        label: "Öğrenci Adı",
                        enabled: true,
                      ),
                      context.addVerticalSpace(0.03),
                      const InputField(
                        label: "Doğum Tarihi",
                        enabled: true,
                      ),
                      context.addVerticalSpace(0.03),
                      const InputField(
                        label: "Öğrenci Yaşı",
                        enabled: true,
                      ),
                      context.addVerticalSpace(0.03),
                      const InputField(
                        label: "Öğrenci Boyu",
                        enabled: true,
                      ),
                      context.addVerticalSpace(0.03),
                      const InputField(
                        label: "Öğrenci Kilosu",
                        textColor: Colors.black,
                        enabled: true,
                      ),
                      context.addVerticalSpace(0.03),
                      const InputField(
                        label: "Kan Grubu",
                        enabled: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
