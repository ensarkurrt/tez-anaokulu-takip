import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme_colors_base.dart';

class LightThemeColors implements BaseThemeColors {
  @override
  Color background = const Color.fromARGB(255, 234, 234, 234);

  @override
  Color main = const Color(0xFFF6FBF4);

  @override
  Color second = const Color.fromARGB(255, 200, 200, 200);

  @override
  Color accent = const Color(0xFFFF9F0A);

  @override
  Color get deactive => const Color(0xFFE8E8E8);
}
