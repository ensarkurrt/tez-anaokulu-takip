import 'package:kindergarden_mobile/service_layer/theme/base/fonts.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/text_colors_base.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme_colors_base.dart';
import 'package:kindergarden_mobile/service_layer/theme/dark/text_colors.dart';
import 'package:kindergarden_mobile/service_layer/theme/dark/theme_colors.dart';

class DarkTheme implements BaseTheme {
  @override
  BaseTextColors get textColors => DarkTextColors();

  @override
  Fonts get fonts => Fonts();

  @override
  BaseThemeColors get themeColors => DarkThemeColors();
}
