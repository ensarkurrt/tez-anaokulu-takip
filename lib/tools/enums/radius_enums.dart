import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

enum RadiusEnums {
  general(0.01);

  final double radiusFactor;

  const RadiusEnums(this.radiusFactor);
}

extension RadiusEnumsExtension on RadiusEnums {
  double get factor => radiusFactor;
  BorderRadius all(BuildContext context) => BorderRadius.circular(context.height * factor);
  BorderRadius horizontal(BuildContext context) =>
      BorderRadius.horizontal(left: Radius.circular(context.width * factor), right: Radius.circular(context.width * factor));
  BorderRadius vertical(BuildContext context) =>
      BorderRadius.vertical(top: Radius.circular(context.height * factor), bottom: Radius.circular(context.height * factor));
  BorderRadius bottomRight(BuildContext context) => BorderRadius.only(bottomRight: Radius.circular(context.height * factor));
  BorderRadius topLeft(BuildContext context) => BorderRadius.only(topLeft: Radius.circular(context.height * factor));
  BorderRadius topRight(BuildContext context) => BorderRadius.only(topRight: Radius.circular(context.height * factor));
  BorderRadius bottomLeft(BuildContext context) => BorderRadius.only(bottomLeft: Radius.circular(context.height * factor));
  BorderRadius right(BuildContext context) =>
      BorderRadius.only(topRight: Radius.circular(context.height * factor), bottomRight: Radius.circular(context.height * factor));
  BorderRadius left(BuildContext context) =>
      BorderRadius.only(topLeft: Radius.circular(context.height * factor), bottomLeft: Radius.circular(context.height * factor));
}
