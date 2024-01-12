import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/image_path_enums.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImagePathEnums.profilePhoto.widget(),
        Expanded(
          child: Column(
            children: [
              const Text(
                "Muhammed Çelik",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: context.height * (1 / 100),
              ),
              const Text("01.01.2024")
            ],
          ),
        )
      ],
    );
  }
}