import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/image_path_enums.dart';

class ProfileInformationComponent extends StatelessWidget {
  ProfileInformationComponent({super.key});

  ImagePathEnums avatarProfile = ImagePathEnums.profileAvatarBig;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        avatarProfile.widget(
          width: context.height * 0.17,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Muhammed Çelik', style: TextStyle(fontSize: context.height * (1.7 / 100))),
              context.addVerticalSpace(0.025),
              Text('15 Ekim 2023 Salı', style: TextStyle(fontSize: context.height * (1.5 / 100), color: const Color(0xFF636366)))
            ],
          ),
        )
      ],
    );
  }
}
