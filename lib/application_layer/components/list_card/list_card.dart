import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/radius_enums.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.body,
    this.onTap,
    required this.icon,
  });
  final Widget body;
  final Function()? onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.width * 0.025),
        decoration: BoxDecoration(
          color: context.themeColors.main,
          borderRadius: RadiusEnums.general.all(context),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            context.addHorizontalSpace(0.05),
            body,
          ],
        ),
      ),
    );
  }
}
