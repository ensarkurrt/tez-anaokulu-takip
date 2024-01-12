import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/scroll_behavior.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/application_layer/features/school/gallery/add_image_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/gallery/components/album_component.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<String>? images;
  Bucket? bucket;
  int? classId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initImages();
    });
    super.initState();
  }

  initImages() async {
    if (SessionManagement.include.isStudent) {
      setState(() => classId = SessionManagement.include.student.classId);
    }

    if (classId == null) return;

    StateManagement.include.changeStateBusy();
    images?.clear();

    try {
      bucket = await supabase.storage.getBucket('class-gallery-$classId');
    } catch (e) {
      String newBucketId = await supabase.storage.createBucket('class-gallery-$classId', const BucketOptions(public: true));
      bucket = await supabase.storage.getBucket(newBucketId);
    }
    if (bucket == null) return initImages();

    List<FileObject> list = await supabase.storage.from(bucket!.id).list();

    images = [];
    for (var element in list.reversed) {
      String path = supabase.storage.from('class-gallery-$classId').getPublicUrl(element.name);
      images?.add(path);
    }

    StateManagement.include.changeStateIdle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Galeri",
          ),
        ),
        floatingActionButton: bucket != null && SessionManagement.include.isSchool
            ? FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddImageView(
                        bucketId: bucket!.id,
                      ),
                    ),
                  );
                  await initImages();
                },
                child: const Icon(Icons.add),
              )
            : null,
        body: PageLayout(
          child: VerticalColumnWithSpace(
            factor: 0.015,
            children: [
              SizedBox(
                  width: context.width,
                  child: ClassesDropdown(onChanged: (id) async {
                    setState(() => classId = id);
                    await initImages();
                  })),
              InfoText(text: "Seçilen sınıf için yüklenen fotoğraflar aşağıda ${classId == null ? "listelenecektir." : "listelenmiştir."}"),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScroll(),
                  child: VerticalListWithSpace(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    factor: 0.02,
                    children: images == null
                        ? [Center(child: classId == null ? const Text("Sınıf Seçiniz") : const CircularProgressIndicator())]
                        : images!.isEmpty
                            ? [
                                const Center(child: Text("Fotoğraf Bulunamadı")),
                              ]
                            : images!
                                .map((e) => CustomGalleryComponent(photoSrc: e, bucket: bucket, onDelete: () async => await initImages()))
                                .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
