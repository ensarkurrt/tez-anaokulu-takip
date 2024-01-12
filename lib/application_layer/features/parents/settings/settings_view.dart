import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/components/card_components.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/components/profile_image.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/general_information/communication_settings_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/general_information/student_diseases.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/general_information/student_information_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/legal_texts/kvkk_agreement_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/legal_texts/user_agreement_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/parent_information/parent_information_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class MainSettings extends StatefulWidget {
  const MainSettings({super.key});

  @override
  State<MainSettings> createState() => _MainSettingsState();
}

class _MainSettingsState extends State<MainSettings> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.appBarSize,
          child: const MaterialCustomAppBar(
            title: "Genel Ayarlar",
          ),
        ),
        body: PageLayout(
          child: VerticalListWithSpace(
            factor: 0.02,
            children: [
              Column(
                children: [
                  const ProfileImage(),
                  PersonCategory(),
                ],
              ),
              SettingCardComponent(
                title: "Veli Bilgileri",
                items: [
                  SettingCardItemModel(
                      title: "Veliler", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ParentInfoView())))
                ],
              ),
              SettingCardComponent(
                title: "Genel Bilgiler",
                items: [
                  SettingCardItemModel(
                      title: "Öğrenci Bilgileri",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentInfoView()))),
                  SettingCardItemModel(
                      title: "İletişim Bilgileri",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CommunicationSettingsView()))),
                  SettingCardItemModel(
                      title: "Öğrenci Hastalıkları",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentDiseasesView()))),
                ],
              ),
              SettingCardComponent(
                title: "Yasal Metinler",
                items: [
                  SettingCardItemModel(
                      title: "Kullanım Koşulları",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KvkkAgreementView()))),
                  SettingCardItemModel(
                      title: "Gizlilik Politikası",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserAgreementView()))),
                ],
              ),
              TMButton(
                title: "Çıkış Yap",
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Center PersonCategory() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text("Öğrenci Velisi", style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
      ),
    );
  }
}
