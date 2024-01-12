import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/announcement/components/announcement_component.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/school/announcement/add_announcement_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/announcement_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';

class AnnouncementView extends StatefulWidget {
  const AnnouncementView({super.key});

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  List<Announcement>? _list;
  int? selectedClass;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (SessionManagement.include.isStudent) {
          await getByStudent();
        } else {
          await getBySchool();
        }
      },
    );
    super.initState();
  }

  Future getByStudent() async {
    StateManagement.include.changeStateBusy();
    if (_list == null) {
      _list = [];
    } else if (_list!.isNotEmpty) {
      _list?.clear();
    }

    var schoolId = SessionManagement.include.student.classId;
    await supabase
        .from('announcements')
        .select()
        .eq('class_id', schoolId)
        .withConverter<List<Announcement>>((data) => data.map((e) => Announcement.fromJson(e)).toList())
        .then((value) {
      setState(() {
        if (value.isNotEmpty) {
          _list?.addAll(value);
        }
        StateManagement.include.changeStateIdle();
      });
    });
  }

  Future getBySchool() async {
    if (selectedClass == null) return;
    StateManagement.include.changeStateBusy();

    if (_list == null) {
      _list = [];
    } else if (_list!.isNotEmpty) {
      _list?.clear();
    }
    await supabase
        .from('announcements')
        .select()
        .eq('class_id', selectedClass!)
        .withConverter<List<Announcement>>((data) => data.map((e) => Announcement.fromJson(e)).toList())
        .then((value) {
      setState(() {
        if (value.isNotEmpty) {
          _list?.addAll(value);
        }
        StateManagement.include.changeStateIdle();
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
            title: "Duyurular",
          ),
        ),
        floatingActionButton: SessionManagement.include.isStudent
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAnnouncementView()));
                  await getBySchool();
                },
                child: const Icon(Icons.add),
              ),
        body: PageLayout(
          child: VerticalListWithSpace(
            shrinkWrap: true,
            factor: 0.02,
            clipBehavior: Clip.none,
            children: [
              ClassesDropdown(
                onChanged: (p0) => setState(() {
                  selectedClass = p0;
                  getBySchool();
                }),
              ),
              InfoText(text: "Sınıfınız için yüklenen duyurular aşağıda ${selectedClass == null ? "listelenecektir." : "listelenmiştir."}"),
              ..._list == null
                  ? selectedClass == null
                      ? [
                          const Center(
                            child: Text("Sınıf Seçin"),
                          )
                        ]
                      : [const Center(child: CircularProgressIndicator())]
                  : _list!.isEmpty
                      ? [const Center(child: Text("Duyuru bulunamadı."))]
                      : [
                          ..._list!
                              .map((e) => CustomAnnouncementComponent(
                                    announcement: e,
                                    onBack: () {
                                      getBySchool();
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
