import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/duration_enums.dart';
import 'package:flutter/material.dart';

class IndicatiorDots extends StatefulWidget {
  final int length;
  final int index;
  const IndicatiorDots({super.key, required this.length, required this.index});

  @override
  State<IndicatiorDots> createState() => _IndicatiorDotsState();
}

class _IndicatiorDotsState extends State<IndicatiorDots> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) => _buildIndicator(index, context)),
    );
  }

  _buildIndicator(int index, BuildContext context) {
    return AnimatedContainer(
      width: index == widget.index ? 15 : 10,
      height: index == widget.index ? 15 : 10,
      margin: EdgeInsets.symmetric(horizontal: context.width * 0.015),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == widget.index ? context.themeColors.main : context.themeColors.main.withOpacity(0.3),
      ),
      duration: Duration(milliseconds: index == widget.index ? DurationEnums.themeChange.time : 500),
    );
  }
}
