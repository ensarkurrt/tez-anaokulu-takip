import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class PageLayout extends StatefulWidget {
  final Widget child;
  final Clip? clipBehavior;
  const PageLayout({
    super.key,
    required this.child,
    this.clipBehavior = Clip.none,
  });

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: widget.clipBehavior ?? Clip.none,
      padding: PaddingEnums.pagePadding.horizontal(context),
      margin: PaddingEnums.pagePaddingHalf.vertical(context),
      child: widget.child,
    );
  }
}
