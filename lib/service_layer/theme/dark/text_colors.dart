import 'dart:ui';

import 'package:kindergarden_mobile/service_layer/theme/base/text_colors_base.dart';

class DarkTextColors implements BaseTextColors {
  @override
  Color deactiveInput = const Color(0xff999999);

  @override
  Color description = const Color(0xffFFFFFF);

  @override
  Color error = const Color(0xffEB4335);

  @override
  Color filledInputForm = const Color(0xffFFFFFF);

  @override
  Color focusTitle = const Color(0xff636075);

  @override
  Color title = const Color(0xff999999);
}
