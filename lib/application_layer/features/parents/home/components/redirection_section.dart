import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/announcement/announcement_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/homework/homework_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/gallery/gallery_view.dart';
import 'package:kindergarden_mobile/application_layer/features/splash/splash_view.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';

class RedirectionSection extends StatelessWidget {
  const RedirectionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = context.height * (5 / 100);
    return VerticalColumnWithSpace(
      children: [
        TMButton(
            title: "Duyurular",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnouncementView()));
            }),
        TMButton(
            title: "Galeri",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GalleryView()));
            }),
        TMButton(
            title: "Ödevler",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeworkView()));
            }),
        TMButton(
            title: "Çıkış Yap",
            backgroundColor: Colors.red,
            onTap: () {
              SessionManagement.include.signOut();
              supabase.auth.signOut();

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashView()), (route) => false);
            })
      ],
    );
  }
}

class RedirectButton extends StatelessWidget {
  const RedirectButton({super.key, required this.icon, required this.text, required this.page});
  final Widget icon;
  final String text;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.navigateTo(page),
      child: SizedBox(
        width: context.height * (10 / 100),
        height: context.height * (12 / 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.height * (1.7 / 100),
              ),
            )
          ],
        ),
      ),
    );
  }
}
