// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/snack_bar/base_snack_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/components/classes_dropdown.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';

class AddImageView extends StatefulWidget {
  final String bucketId;
  const AddImageView({super.key, required this.bucketId});

  @override
  State<AddImageView> createState() => _AddImageViewState();
}

class _AddImageViewState extends State<AddImageView> {
  int? classId;

  XFile? _imageFile;
  ImagePicker? _picker;
  bool _isUploading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: context.materialAppBarSize,
            child: const MaterialCustomAppBar(
              title: "Resim Ekle",
            ),
          ),
          body: PageLayout(
            child: VerticalColumnWithSpace(
              children: [
                SizedBox(width: double.infinity, child: ClassesDropdown(onChanged: (id) => setState(() => classId = id))),
                TMButton(
                    isActive: classId != null && !_isUploading,
                    title: "Resim Seç",
                    backgroundColor: Colors.green,
                    onTap: () {
                      showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: ((builder) => ChangeImage()));
                    }),
                TMButton(
                  title: _isUploading ? "Yükleniyor! Lütfen Bekleyin..." : "Yükle",
                  onTap: () async {
                    if (_imageFile == null) {
                      context.showSnackBar(text: "Lütfen bir resim seçin", alertType: CustomAlertType.Error);
                      return;
                    }
                    StateManagement.include.changeStateBusy();
                    setState(() => _isUploading = true);
                    await supabase.storage.from(widget.bucketId).upload("${DateTime.now().microsecondsSinceEpoch}.jpg", File(_imageFile!.path));
                    StateManagement.include.changeStateIdle();
                    context.showSnackBar(text: "Resim Yüklendi", alertType: CustomAlertType.Success);
                    Navigator.pop(context);
                  },
                  isActive: _imageFile != null && classId != null && !_isUploading,
                ),
              ],
            ),
          )),
    );
  }

  Widget button(String title, ImageSource source) {
    return GestureDetector(
      onTap: () => takephoto(source),
      child: Text(
        title,
        style: context.fonts.body.copyWith(color: context.textColors.filledInputForm),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget ChangeImage() {
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
              "Profil Fotoğrafınızı Seçiniz",
              style: context.fonts.title.copyWith(color: context.textColors.filledInputForm),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          context.addVerticalSpace(0.02),
          button("Kamera", ImageSource.camera),
          context.addVerticalSpace(0.03),
          button("Galeri", ImageSource.gallery),
        ],
      ),
    );
  }

  void takephoto(ImageSource source) async {
    _picker = ImagePicker();
    final pickedFile = await _picker?.pickImage(
      source: source,
    );
    if (pickedFile == null) return;
    setState(() {
      _imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}
