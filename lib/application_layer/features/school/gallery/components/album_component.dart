import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/image_path_enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomGalleryComponent extends StatefulWidget {
  final ImagePathEnums? photo;
  final String? photoSrc;
  final Bucket? bucket;
  final Function? onDelete;

  const CustomGalleryComponent({super.key, this.photo, this.photoSrc, this.bucket, this.onDelete});

  @override
  State<CustomGalleryComponent> createState() => _CustomGalleryComponentState();
}

class _CustomGalleryComponentState extends State<CustomGalleryComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SessionManagement.include.isSchool
          ? showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: ((builder) => Options()))
          : {},
      child: Container(
        width: double.infinity,
        height: context.height * (30 / 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: widget.photoSrc != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.photoSrc!,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              )
            : widget.photo?.widget(),
      ),
    );
  }

  Widget Options() {
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
            String fileName = widget.photoSrc!.toString().split('/').last;
            await supabase.storage.from(widget.bucket!.id).remove([fileName]);
            StateManagement.include.changeStateIdle();
            context.showSnackBar(text: "Görsel silindi.");
            widget.onDelete!();
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
