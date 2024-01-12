import 'package:flutter/material.dart';

import '../../../service_layer/extensions/context_extention.dart';

class BaseContainerForList extends StatefulWidget {
  final String? title;
  final Widget child;
  final Widget? titleWidget;
  const BaseContainerForList({super.key, this.title, required this.child, this.titleWidget});

  @override
  State<BaseContainerForList> createState() => _BaseContainerForListState();
}

class _BaseContainerForListState extends State<BaseContainerForList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null ? BaseContainerTitle(title: widget.title!) : Container(),
        widget.title != null ? SizedBox(height: context.height * 0.02) : Container(),
        widget.titleWidget ?? Container(),
        widget.child,
      ],
    );
  }
}

class BaseContainerTitle extends StatefulWidget {
  final String title;
  const BaseContainerTitle({super.key, required this.title});

  @override
  State<BaseContainerTitle> createState() => _BaseContainerTitleState();
}

class _BaseContainerTitleState extends State<BaseContainerTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title, style: TextStyle(fontSize: context.height * .02, fontWeight: FontWeight.bold));
  }
}
