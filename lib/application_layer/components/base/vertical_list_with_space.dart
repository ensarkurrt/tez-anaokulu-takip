import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/scroll_behavior.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class VerticalListWithSpace extends StatefulWidget {
  final List<Widget> children;
  final double factor;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Clip clipBehavior;
  const VerticalListWithSpace({
    super.key,
    required this.children,
    this.factor = 0.15,
    this.physics = const ClampingScrollPhysics(),
    this.shrinkWrap = false,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  State<VerticalListWithSpace> createState() => _VerticalListWithSpaceState();
}

class _VerticalListWithSpaceState extends State<VerticalListWithSpace> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScroll(),
      child: ListView.separated(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        clipBehavior: widget.clipBehavior,
        itemBuilder: (context, index) => widget.children[index],
        separatorBuilder: (context, index) => context.addVerticalSpace(widget.factor),
        itemCount: widget.children.length,
      ),
    );
  }
}
