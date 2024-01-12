import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:kindergarden_mobile/tools/enums/image_path_enums.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  void takephoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );

    setState(() {
      _imageFile = pickedFile as PickedFile;
    });
  }

  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 55.0,
          backgroundImage: AssetImage(ImagePathEnums.settingsPhoto.path),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(2, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(context.height * 0.02),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: ((builder) => ChangeImage()));
              },
              child: IconPathEnums.camera.widget(height: context.height * 0.035, width: context.width * 0.035),
            ),
          ),
        ),
      ],
    ));
  }

  // ignore: non_constant_identifier_names
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
}
