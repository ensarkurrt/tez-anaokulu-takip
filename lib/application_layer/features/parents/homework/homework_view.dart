import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/homework/components/homework_list_item.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/application_layer/features/school/homework/add_homework_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/homework_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';

class HomeworkView extends StatefulWidget {
  const HomeworkView({super.key});
  @override
  State<HomeworkView> createState() => _HomeworkViewState();
}

class _HomeworkViewState extends State<HomeworkView> {
  List<HomeWork>? homeworkList;
  int? selectedClass;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await getBySession();
      },
    );
    super.initState();
  }

  Future getBySession() async {
    StateManagement.include.changeStateBusy();
    if (SessionManagement.include.isStudent) {
      await getByStudent();
    } else {
      await getBySchool();
    }
    StateManagement.include.changeStateIdle();
  }

  Future getByStudent() async {
    if (homeworkList == null) {
      homeworkList = [];
    } else {
      homeworkList?.clear();
    }
    var classId = SessionManagement.include.student.classId;

    await supabase
        .from('homeworks')
        .select()
        .eq('class_id', classId)
        .withConverter<List<HomeWork>>((data) => data.map((e) => HomeWork.fromJson(e)).toList())
        .then((value) async {
      for (var element in value) {
        var studentId = SessionManagement.include.student.id;
        int count = await supabase.from('homework_process').count().eq('homework_id', element.id).eq('student_id', studentId);
        if (count != 0) {
          element.isDone = true;
        }
      }
      setState(() {
        homeworkList?.addAll(value);
      });
    });
  }

  Future getBySchool() async {
    if (selectedClass == null) return;

    if (homeworkList == null) {
      homeworkList = [];
    } else {
      homeworkList?.clear();
    }

    await supabase
        .from('homeworks')
        .select()
        .eq('class_id', selectedClass!)
        .withConverter<List<HomeWork>>((data) => data.map((e) => HomeWork.fromJson(e)).toList())
        .then((value) async {
      for (var element in value) {
        element.isDone = true;
      }

      setState(() {
        homeworkList?.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Ödevler",
          ),
        ),
        floatingActionButton: SessionManagement.include.isStudent
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddHomeworkView()));
                  await getBySchool();
                },
                child: const Icon(Icons.add),
              ),
        body: PageLayout(
          child: VerticalListWithSpace(
            factor: 0.02,
            children: [
              ClassesDropdown(
                onChanged: (p0) => setState(() {
                  selectedClass = p0;
                  getBySchool();
                }),
              ),
              const InfoText(text: "Öğrencinizin ödevi yapıp yapmadığını buradan takip edebilirsiniz"),
              ...homeworkList == null
                  ? selectedClass == null
                      ? [const Center(child: Text("Sınıf Seçin"))]
                      : [const Center(child: CircularProgressIndicator())]
                  : homeworkList!.isEmpty
                      ? [const Center(child: Text("Ödev bulunamadı"))]
                      : [
                          ...homeworkList!
                              .map((e) => HomeworkListItem(
                                    homework: e,
                                    onBack: () async {
                                      await getBySession();
                                    },
                                  ))
                              .toList()
                        ]
            ],
          ),
        ),
      ),
    );
  }
}
