// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kindergarden_mobile/application_layer/components/snack_bar/base_snack_bar.dart';
import 'package:provider/provider.dart';

import '../logger/logger.dart';
import '../providers/state_management.dart';
import '../theme/base/fonts.dart';
import '../theme/base/text_colors_base.dart';
import '../theme/base/theme_colors_base.dart';
import '../theme/theme_management.dart';

extension ContextExtention on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;

  Future hideKeyboard() async {
    FocusScope.of(this).requestFocus(FocusNode());
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Future copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Logger.instance.log('Message copied. Message: $text');
  }

  Future navigateTo(Widget page, {bool replace = false}) async {
    if (replace) {
      await Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      await Navigator.push(
        this,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    CustomAlertType alertType = CustomAlertType.Success,
    required String text,
    Color color = Colors.white,
    int duration = 2000,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: duration),
        backgroundColor: alertTypeToColor(customAlertType: alertType),
        elevation: 3,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(10),
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            /* mainAxisAlignment: MainAxisAlignment.center, */
            children: [
              alertTypeToIcon(this, customAlertType: alertType, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  maxLines: 5,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showDateTimePicker({required DateTime firstDate, required DateTime lastDate, required DateTime initialDate}) async {
    DateTime? date = await showDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      keyboardType: TextInputType.text,
      context: this,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.themeColors.main,
              onPrimary: Colors.white,
              onSurface: context.textColors.filledInputForm,
            ),
            dialogBackgroundColor: context.themeColors.background,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: context.themeColors.main,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null) {
      Logger.instance.log('Date is null');
      return null;
    }

    TimeOfDay? time = await showTimePicker(
      context: this,
      initialTime: TimeOfDay.fromDateTime(initialDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.themeColors.main,
              onSurface: context.textColors.filledInputForm,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: context.themeColors.background,
              hourMinuteTextColor: context.textColors.filledInputForm,
              helpTextStyle: TextStyle(color: context.textColors.filledInputForm),
              dayPeriodTextColor: context.textColors.filledInputForm,
            ),
            dialogBackgroundColor: context.themeColors.background,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: context.themeColors.main,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }

    return date;
  }

  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  Future dialog(BuildContext context, {required List<Widget> actions, String title = 'Bilgilendirme', required String content}) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Text(
          content,
          style: const TextStyle(fontSize: 15),
        ),
        actions: actions,
      ),
    );
  }
/*
  String locale(LanguageLocalizationKeys pageKey, Enum keyEnum, {bool upperCase = false}) =>
      LocalizationService.include.tr(pageKey.snakeCase, upperCase ? keyEnum.snakeCase.toUpperCase() : keyEnum.snakeCase); */

  /* Theme Extentions */
  ThemeManagement get theme => ThemeManagement.include;
  Future changeTheme({ThemeState? themeState}) async => await theme.changeTheme(themeState: themeState);
  BaseTextColors get textColors => watch<ThemeManagement>().theme.textColors;
  BaseTextColors get rTextColors => watch<ThemeManagement>().reverseTheme.textColors;
  BaseThemeColors get themeColors => watch<ThemeManagement>().theme.themeColors;
  BaseThemeColors get rThemeColors => watch<ThemeManagement>().reverseTheme.themeColors;

  StateManagement get state => watch<StateManagement>();

  Fonts get fonts => watch<ThemeManagement>().theme.fonts;
  bool get isDark => watch<ThemeManagement>().state == ThemeState.Dark;
  bool get isLight => watch<ThemeManagement>().state == ThemeState.Light;

  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;

  SizedBox addHorizontalSpace(double widthFactor) {
    return SizedBox(
      width: width * widthFactor,
    );
  }

  SizedBox addVerticalSpace(double heightFactor) {
    return SizedBox(
      height: height * heightFactor,
    );
  }

  Size get appBarSize => Size.fromHeight(height * 0.07);
  Size get materialAppBarSize => Size.fromHeight(height * 0.05);
}
