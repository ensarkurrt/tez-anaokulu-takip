import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/duration_enums.dart';

class TMButton extends StatefulWidget {
  final String title;
  final Widget? icon;
  final bool? isPrimary;
  final bool? isActive;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  const TMButton({
    super.key,
    required this.title,
    this.isPrimary = true,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.isActive = true,
    this.icon,
  });

  @override
  State<TMButton> createState() => _TMButtonState();
}

class _TMButtonState extends State<TMButton> {
  Color get _backgroundColor => widget.isActive!
      ? (widget.backgroundColor ?? (widget.isPrimary! ? context.themeColors.accent : Colors.transparent))
      : context.themeColors.second;
  Color get _borderColor => widget.borderColor ?? (widget.isPrimary! ? Colors.transparent : context.themeColors.main);
  Color get _textColor => widget.textColor ?? (widget.isPrimary! ? Colors.white : (context.isDark ? Colors.white : Colors.black));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => widget.isActive! ? await widget.onTap() : null,
      child: AnimatedContainer(
          duration: DurationEnums.themeChange.duration,
          /* margin: EdgeInsets.only(right: false ? context.width * 0.02 : 0), */
          height: context.height * 0.07,
          width: context.width /* * 0.35 */,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon!,
              if (widget.icon != null) SizedBox(width: context.width * 0.03),
              Text(
                widget.title,
                style: context.fonts.button.copyWith(color: _textColor),
              )
            ],
          )),
    );
  }
}
