import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/scroll_behavior.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class VerticalColumnWithSpace extends StatefulWidget {
  final List<Widget> children;
  final double factor;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const VerticalColumnWithSpace({
    super.key,
    required this.children,
    this.factor = 0.015,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  @override
  State<VerticalColumnWithSpace> createState() => _VerticalColumnWithSpaceState();
}

class _VerticalColumnWithSpaceState extends State<VerticalColumnWithSpace> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScroll(),
      child: Column(
        crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          for (int i = 0; i < widget.children.length; i++) ...[
            widget.children[i],
            if (i != widget.children.length - 1) context.addVerticalSpace(widget.factor),
          ]
        ],
      ),
    );
  }
}
