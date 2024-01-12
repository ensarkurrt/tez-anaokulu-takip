import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

enum PaddingEnums {
  pagePadding(0.03),
  pagePaddingHalf(0.015),
  cardPadding(0.015),
  listPadding(0.015);

  final double factor;

  const PaddingEnums(this.factor);
}

extension PaddingEnumsExtension on PaddingEnums {
  double get factor => this.factor;
  EdgeInsets horizontal(BuildContext context) => EdgeInsets.symmetric(horizontal: context.width * factor);
  EdgeInsets vertical(BuildContext context) => EdgeInsets.symmetric(vertical: context.height * factor);
  EdgeInsets all(BuildContext context) => EdgeInsets.all(context.height * factor);
}
