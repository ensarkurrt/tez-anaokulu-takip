import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme_colors_base.dart';

class DarkThemeColors implements BaseThemeColors {
  @override
  Color background = const Color.fromARGB(255, 137, 137, 141);

  @override
  Color deactive = const Color(0xFFD9D7D6);

  @override
  Color main = const Color(0xFF212123);

  @override
  Color second = const Color(0xFF1e1e20);

  @override
  Color accent = const Color(0xFFFF9F0A);
}
