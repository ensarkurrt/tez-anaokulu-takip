// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/application_layer/features/school/student/add_student_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/student_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  List<Student>? students;
  int? selectedClassId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => await getStudents());
    super.initState();
  }

  Future getStudents() async {
    if (selectedClassId == null) return;
    StateManagement.include.changeStateBusy();
    if (students == null) {
      students = [];
    } else if (students!.isNotEmpty) {
      students!.clear();
    }

    List<Student> std = await supabase
        .from('students')
        .select()
        .eq('class_id', selectedClassId!)
        .withConverter<List<Student>>((data) => data.map((e) => Student.fromJson(e)).toList());

    setState(() => students!.addAll(std));
    StateManagement.include.changeStateIdle();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Öğrenciler",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudentView()));
            await getStudents();
          },
          child: const Icon(Icons.add),
        ),
        body: PageLayout(
          child: VerticalColumnWithSpace(
            children: [
              SizedBox(
                  width: context.width,
                  child: ClassesDropdown(onChanged: (id) async {
                    setState(() => selectedClassId = id);
                    await getStudents();
                  })),
              const InfoText(text: "Sınıflarınızda kayıtlı öğrencileri görebilirsiniz."),
              ...students == null
                  ? selectedClassId == null
                      ? [const Center(child: Text("Lütfen sınıf seçiniz."))]
                      : [const Center(child: CircularProgressIndicator())]
                  : students!.isEmpty
                      ? [const Center(child: Text("Sınıfınızda öğrenci bulunmamaktadır."))]
                      : [...students!.map((e) => _buildStudentTile(e))]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentTile(Student item) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: ((builder) => Options(item)));
        await getStudents();
      },
      child: Container(
        padding: PaddingEnums.cardPadding.all(context),
        width: context.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(item.name ?? "Adı Yok", style: context.fonts.title.copyWith(color: Colors.black)),
      ),
    );
  }

  Widget Options(Student item) {
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
            await supabase.from('students').delete().eq('id', item.id);
            StateManagement.include.changeStateIdle();
            context.showSnackBar(text: "Öğrenci silindi.");
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
