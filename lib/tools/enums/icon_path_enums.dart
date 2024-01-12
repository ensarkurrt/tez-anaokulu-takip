import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum IconPathEnums {
  eye('eye.svg'),
  eyeOpen('eye_open.svg'),
  xMarkCircle('x_mark_circle.svg'),
  xMark('x_mark.svg'),
  arrowLeft('arrow_left.svg'),
  rightCalendar('right_calendar.svg'),
  leftCalendar('left_calendar.svg'),
  noConnection('no_connection.svg'),
  bolt('bolt.svg'),
  add('add.svg'),
  download('download.svg'),
  circleExclamation('circle_exclamation.svg'),
  circleQuestion('circle_question.svg'),
  circleXmark('circle_x_mark.svg'),
  greenVerified('green_verified.svg'),
  redDenied('red_denied.svg'),
  announcement('announcement.svg'),
  pdf('pdf.svg'),
  circleX('x.svg'),
  confirm('confirm.svg'),
  circleCheck('circle_check.svg'),
  cancel('cancel.svg'),
  info('info.svg'),
  school('School.svg'),
  male('Male.svg'),
  acrobat('acrobat.svg'),
  settingsGear('settings_gear.svg'),
  megaphone('megaphone.svg'),
  presentation('presentation.svg'),
  food('food.svg'),
  teacher('teacher.svg'),
  capsule('capsule.svg'),
  pills('pills.svg'),
  information('information.svg'),
  documentPdf('document_pdf.svg'),
  next('next.svg'),
  camera('camera.svg');

  final String _path;

  const IconPathEnums(this._path);
}

extension IconPathEnumsExtension on IconPathEnums {
  String get path => 'assets/icons/$_path';
  // ignore: deprecated_member_use
  Widget widget({Color? color, double? width, double? height}) =>
      _path.contains('.svg')
          // ignore: deprecated_member_use
          ? SvgPicture.asset(path,
              color: color, width: width, height: height, fit: BoxFit.fill)
          : Image.asset(path,
              color: color, height: height, width: width, fit: BoxFit.fill);
}
