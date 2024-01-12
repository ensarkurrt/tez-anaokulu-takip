import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/activity_program/components/activity_program_component.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/activity_program/components/animated_container_component.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/activity_model.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class ActivityProgramView extends StatefulWidget {
  const ActivityProgramView({super.key});

  @override
  State<ActivityProgramView> createState() => _ActivityProgramViewState();
}

class _ActivityProgramViewState extends State<ActivityProgramView> {
  int selectedDay = 0;

  void onIndexChange(int index) {
    setState(() => selectedDay = index);
  }

  final List<ActivityModel> _activities = [
    ActivityModel(time: '09:30', activityName: "İngilizce", date: DateTime.now().add(const Duration(days: 1))),
    ActivityModel(time: '10:35', activityName: "İngilizce2", date: DateTime.now().add(const Duration(days: 1))),
    ActivityModel(time: '11:50', activityName: "İngilizce3", date: DateTime.now().add(const Duration(days: 1))),
    ActivityModel(time: '12:00', activityName: "İngilizce4", date: DateTime.now().add(const Duration(days: 1))),
    ActivityModel(time: '11:50', activityName: "İngilizce5", date: DateTime.now().add(const Duration(days: 1))),
    ActivityModel(time: '12:00', activityName: "İngilizce6", date: DateTime.now().add(const Duration(days: 1))),
    ActivityModel(time: '09:30', activityName: "Matematik", date: DateTime.now().add(const Duration(days: 2))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 2))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 2))),
    ActivityModel(time: '12:00', activityName: "Matematik4", date: DateTime.now().add(const Duration(days: 2))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 2))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 2))),
    ActivityModel(time: '09:30', activityName: "aMatematik", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '12:00', activityName: "Matematik4", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '12:00', activityName: "Matematik4", date: DateTime.now().add(const Duration(days: 3))),
    ActivityModel(time: '09:30', activityName: "bMatematik", date: DateTime.now().add(const Duration(days: 4))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 4))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 4))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 4))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 4))),
    ActivityModel(time: '12:00', activityName: "Matematik4", date: DateTime.now().add(const Duration(days: 4))),
    ActivityModel(time: '09:30', activityName: "cMatematik", date: DateTime.now().add(const Duration(days: 5))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 5))),
    ActivityModel(time: '10:35', activityName: "Matematik2", date: DateTime.now().add(const Duration(days: 5))),
    ActivityModel(time: '11:50', activityName: "Matematik3", date: DateTime.now().add(const Duration(days: 5))),
    ActivityModel(time: '12:00', activityName: "Matematik4", date: DateTime.now().add(const Duration(days: 5))),
  ];

  List<ActivityModel> get _filteredActivities => _activities.where((e) => (e.date.weekday - 1) == selectedDay).toList();

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Etkinlik Programı",
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: PaddingEnums.pagePadding.horizontal(context),
          child: Column(
            children: [
              context.addVerticalSpace(0.01),
              CustomAnimatedContainerComponent(onIndexChange: onIndexChange),
              context.addVerticalSpace(0.01),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _filteredActivities.length,
                  itemBuilder: (context, index) => CustomActivityProgramComponent(activityModel: _filteredActivities[index]),
                  separatorBuilder: (context, index) => context.addVerticalSpace(0.01),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
