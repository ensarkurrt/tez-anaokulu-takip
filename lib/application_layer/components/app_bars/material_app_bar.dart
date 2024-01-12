import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/providers/state_management.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

import '../../../service_layer/extensions/context_extention.dart';

class MaterialCustomAppBar extends StatefulWidget {
  final String? title;
  final Function? onPop;
  final bool? havePop;
  final Color? backgroundColor;
  final bool? centerTitle;
  final Color? leadingColor;
  final Widget? leading;
  final double? leadingSize;
  final Color? titleColor;
  final List<Widget>? actions;
  final Map<String, dynamic>? popArguments;
  const MaterialCustomAppBar({
    super.key,
    this.title,
    this.onPop,
    this.havePop = true,
    this.backgroundColor,
    this.leadingColor,
    this.actions,
    this.titleColor,
    this.popArguments,
    this.leading,
    this.leadingSize,
    this.centerTitle = false,
  });

  @override
  State<MaterialCustomAppBar> createState() => _MaterialCustomAppBarState();
}

class _MaterialCustomAppBarState extends State<MaterialCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.themeColors.background,
      elevation: 0,
      leadingWidth: context.width * 0.2,
      leading: (widget.havePop ?? true)
          ? IconButton(
              splashRadius: 1,
              onPressed: () {
                if (StateManagement.include.state == ViewStateEnum.Busy) return;
                if (widget.onPop != null) {
                  widget.onPop!();
                }
                Navigator.maybePop(context, widget.popArguments);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              icon: widget.leading ??
                  IconPathEnums.arrowLeft
                      .widget(color: widget.leadingColor ?? context.textColors.filledInputForm, height: widget.leadingSize ?? context.height * 0.025))
          : null,
      centerTitle: widget.centerTitle,
      toolbarHeight: context.height,
      title: widget.title == null
          ? null
          : Text(
              widget.title!,
              style: context.fonts.title.copyWith(color: widget.titleColor ?? context.textColors.filledInputForm),
            ),
      actions: widget.actions,
    );
  }
}
