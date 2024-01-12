import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Merhaba,",
          style: context.fonts.huge.copyWith(
            color: context.textColors.title,
          ),
        ),
        Text(
          SessionManagement.include.user.name ?? "",
          style: context.fonts.huge.copyWith(
            color: context.textColors.title,
          ),
        ),
      ],
    );
  }
}
