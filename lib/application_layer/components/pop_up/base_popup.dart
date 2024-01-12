import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../service_layer/extensions/context_extention.dart';
import '../../../service_layer/firebase/enums/analytic_events.dart';

class PopUpAction {
  String title;
  PopUpActionType? type;
  Function onTap;
  AnalyticEvents? analyticEvent;
  PopUpAction({this.analyticEvent, this.type = PopUpActionType.positive, required this.title, required this.onTap});
}

enum PopUpActionType { negative, positive }

enum PopUpType { info, warning, error, success }

class BasePopUp extends StatefulWidget {
  final String title;
  final String subTitle;
  final List<PopUpAction> actions;
  final AnalyticEvents? analyticEvent;
  final IconData? icon;
  final String? iconPath;
  final PopUpType? type;
  const BasePopUp({
    super.key,
    required this.title,
    required this.subTitle,
    required this.actions,
    this.analyticEvent,
    this.icon,
    this.iconPath,
    this.type = PopUpType.info,
  });

  @override
  State<BasePopUp> createState() => _BasePopUpState();
}

class _BasePopUpState extends State<BasePopUp> {
  Color get _typeColor {
    switch (widget.type) {
      case PopUpType.error:
        return Colors.red;
      case PopUpType.success:
        return const Color(0xFF359F60);
      case PopUpType.warning:
        return Colors.orange[800]!;
      case PopUpType.info:
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(4), right: Radius.circular(4))),
      child: SizedBox(
        height: context.height * 0.3,
        width: context.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  height: 7,
                  margin: EdgeInsets.only(top: context.height * 0.035),
                  decoration: BoxDecoration(
                    color: _typeColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                  child: Container(),
                ),
                Expanded(
                  child: Container(
                    width: context.width,
                    padding: (widget.icon == null && widget.iconPath == null ? const EdgeInsets.only() : EdgeInsets.only(top: context.height * 0.025))
                        .add(EdgeInsets.symmetric(horizontal: context.width * 0.04)),
                    decoration: BoxDecoration(
                      color: context.themeColors.background,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.title, style: context.fonts.title.copyWith(color: context.textColors.filledInputForm)),
                          Text(widget.subTitle,
                              style: context.fonts.body.copyWith(color: context.textColors.deactiveInput), textAlign: TextAlign.center),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widget.actions
                                .map((e) => Expanded(
                                      child: popUpButton(
                                        context,
                                        e,
                                        isPositive: e.type == PopUpActionType.positive,
                                        space: widget.actions.indexOf(e) != widget.actions.length - 1,
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            widget.icon == null && widget.iconPath == null
                ? Container()
                : Container(
                    decoration: BoxDecoration(color: context.themeColors.main, borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(context.width * 0.03),
                    child: widget.icon != null
                        ? Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 40,
                          )
                        // ignore: deprecated_member_use
                        : (widget.iconPath != null ? SvgPicture.asset(widget.iconPath!, height: 40, width: 40, color: Colors.white) : Container()),
                  ),
          ],
        ),
      ),
    );
  }

  Center popUpButton(BuildContext context, PopUpAction action, {bool isPositive = true, bool space = false}) {
    Color background = isPositive ? context.themeColors.main : context.themeColors.background;
    Color borderColor = context.themeColors.main;
    Color textColor = (context.isDark ? Colors.white : (isPositive ? Colors.black : Colors.black));

    return Center(
      child: GestureDetector(
        onTap: () async {
          action.onTap();
        },
        child: Container(
          margin: EdgeInsets.only(right: space ? context.width * 0.02 : 0),
          height: context.height * 0.045,
          decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(10), border: Border.all(color: borderColor)),
          child: Center(
            child: Text(action.title, style: context.fonts.body.copyWith(color: textColor)),
          ),
        ),
      ),
    );
  }
}
