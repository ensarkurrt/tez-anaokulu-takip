import 'package:kindergarden_mobile/service_layer/theme/base/fonts.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/text_colors_base.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme_colors_base.dart';

abstract class BaseTheme {
  BaseTextColors get textColors;
  BaseThemeColors get themeColors;
  Fonts get fonts;
}
