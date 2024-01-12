import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/app_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/medication_tracking/arrange_medication_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/medication_tracking/medication_tracking_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class ManageMedicationsView extends StatefulWidget {
  const ManageMedicationsView({super.key});

  @override
  State<ManageMedicationsView> createState() => _ManageMedicationsViewState();
}

class _ManageMedicationsViewState extends State<ManageMedicationsView> {
  IconPathEnums information = IconPathEnums.information;
  IconPathEnums acrobat = IconPathEnums.acrobat;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.height * 0.07),
          child: const CustomAppBar(
            title: "İlaç Takibi",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: context.height * 0.05, left: context.width * 0.04, right: context.width * 0.04),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Güncel İlaçlarım',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                context.addVerticalSpace(0.01),
                ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: context.height * 0.05,
                      width: context.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), color: Color(0xFFFF9F0A)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('İlaç', style: TextStyle(color: Colors.white)),
                          Text('Başlangıç T.', style: TextStyle(color: Colors.white)),
                          Text('Bitiş T.', style: TextStyle(color: Colors.white)),
                          Text('Durum', style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    Container(
                      height: context.height * 0.234,
                      width: context.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 2, offset: Offset(0, 2), color: Colors.black12)]),
                      child: Column(
                        children: [
                          const ListText(),
                          const ListText(),
                          context.addVerticalSpace(0.02),
                          const Divider(),
                          Row(
                            children: [
                              context.addHorizontalSpace(0.03),
                              acrobat.widget(),
                              context.addHorizontalSpace(0.02),
                              Expanded(
                                  child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan id odio id porttitor. Proin sodales justo dictum nunc tincidunt semper. ',
                                style: TextStyle(fontSize: context.height * 0.014),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                context.addVerticalSpace(0.1),
                Center(
                    child: CustomElevatedButton(
                        text: 'Yeni İlaç Tanımla',
                        color: Colors.red,
                        widht: context.width * 0.5,
                        height: context.height * 0.05,
                        page: const ArrangeMedicationView()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListText extends StatelessWidget {
  const ListText({super.key});
  Text text(String textt) => Text(
        textt,
        style: const TextStyle(color: Color(0xFF636366)),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.addVerticalSpace(0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            text('C Vitamini'),
            text('21.03.2024'),
            text('30.03.2024'),
            GestureDetector(
                onTap: () => context.navigateTo(const ArrangeMedicationView()),
                child: const Text(
                  'Düzenle',
                  style: TextStyle(color: Colors.red, decoration: TextDecoration.underline, decorationColor: Colors.red),
                ))
          ],
        )
      ],
    );
  }
}
