import 'package:kindergarden_mobile/service_layer/theme/base/fonts.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/text_colors_base.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme_colors_base.dart';
import 'package:kindergarden_mobile/service_layer/theme/light/text_colors.dart';
import 'package:kindergarden_mobile/service_layer/theme/light/theme_colors.dart';

class LightTheme implements BaseTheme {
  @override
  BaseTextColors get textColors => LightTextColors();

  @override
  Fonts get fonts => Fonts();

  @override
  BaseThemeColors get themeColors => LightThemeColors();
}
