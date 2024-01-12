import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class CircleIndicator extends StatelessWidget {
  final double? size;

  const CircleIndicator({Key? key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 50,
      height: size ?? 50,
      child: CircularProgressIndicator(
        strokeWidth: 1.2,
        valueColor: AlwaysStoppedAnimation<Color>(context.themeColors.main),
      ),
    );
  }
}
