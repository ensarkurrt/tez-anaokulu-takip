import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/app_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/medication_tracking/components/medicine_component.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/medication_tracking/components/profile_information_component.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/medication_tracking/manage_medications_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class MedicationTrackingView extends StatefulWidget {
  const MedicationTrackingView({super.key});

  @override
  State<MedicationTrackingView> createState() => _MedicationTrackingViewState();
}

class _MedicationTrackingViewState extends State<MedicationTrackingView> {
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
          padding: EdgeInsets.only(top: context.height * 0.038),
          child: Column(
            children: [
              ProfileInformationComponent(),
              const Divider(thickness: 2),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    MedicineComponent(),
                    context.addVerticalSpace(0.017),
                    MedicineComponent(),
                    context.addVerticalSpace(0.017),
                    MedicineComponent(),
                  ],
                ),
              ),
              context.addVerticalSpace(0.05),
              CustomElevatedButton(
                text: 'İlaçları Yönet',
                color: const Color(0xFF34C759),
                widht: context.width * 0.36,
                height: context.height * 0.05,
                page: const ManageMedicationsView(),
              ),
              context.addVerticalSpace(0.05),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MedicineComponent(),
        context.addVerticalSpace(0.017),
        MedicineComponent(),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({super.key, required this.text, required this.color, required this.widht, required this.height, required this.page});

  String text;
  Color color;
  double widht;
  double height;
  Widget page;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.navigateTo(page);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Düzgün köşeli kenarlar
          ),
          fixedSize: Size(widht, height),
          side: BorderSide(width: 0.7, color: color)),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
