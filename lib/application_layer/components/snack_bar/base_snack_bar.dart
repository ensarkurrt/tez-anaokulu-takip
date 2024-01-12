import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

// ignore: constant_identifier_names
enum CustomAlertType { Success, Warning, Error, Info }

// ignore: non_constant_identifier_names
ShowSnackBar(
  context, {
  CustomAlertType alertType = CustomAlertType.Success,
  required String text,
  Color color = Colors.white,
  int duration = 2000,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
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
            alertTypeToIcon(context, customAlertType: alertType, color: color),
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

Widget alertTypeToIcon(BuildContext context, {required CustomAlertType customAlertType, required Color color}) {
  switch (customAlertType) {
    case CustomAlertType.Error:
      return IconPathEnums.circleXmark.widget(color: color, width: context.width * 0.05);
    case CustomAlertType.Success:
      return IconPathEnums.circleCheck.widget(color: color);
    case CustomAlertType.Warning:
      return IconPathEnums.circleExclamation.widget(color: color);
    case CustomAlertType.Info:
      return IconPathEnums.circleQuestion.widget(color: color);
    default:
      return IconPathEnums.circleCheck.widget(color: color);
  }
}

alertTypeToColor({required CustomAlertType customAlertType}) {
  switch (customAlertType) {
    case CustomAlertType.Error:
      return Colors.red;
    case CustomAlertType.Success:
      return const Color(0xFF359F60);
    case CustomAlertType.Warning:
      return Colors.orange[800];
    case CustomAlertType.Info:
      return Colors.blue;
    default:
      return Colors.green;
  }
}
