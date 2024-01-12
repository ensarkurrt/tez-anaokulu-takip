import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class CustomAnimatedContainerComponent extends StatefulWidget {
  final Function(int) onIndexChange;
  const CustomAnimatedContainerComponent({super.key, required this.onIndexChange});

  @override
  State<CustomAnimatedContainerComponent> createState() => _CustomAnimatedContainerComponentState();
}

class _CustomAnimatedContainerComponentState extends State<CustomAnimatedContainerComponent> {
  List<String> days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum'];

  int selectedDay = 0;

  void onTap(int index) {
    setState(() => selectedDay = index);
    widget.onIndexChange(index);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int dayIndex = DateTime.now().weekday;
      if (dayIndex > 5) dayIndex = 0;

      onTap(dayIndex);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days.map((e) => _dayContainer(e)).toList(),
    );
  }

  Widget _dayContainer(String dayName) {
    int index = days.indexOf(dayName);

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: context.height * (selectedDay == index ? 0.08 : 0.06),
        margin: EdgeInsets.all(context.width * 0.01),
        width: context.width * (selectedDay == index ? 0.17 : 0.14),
        decoration: BoxDecoration(
          color: selectedDay == index ? context.themeColors.accent : context.themeColors.main,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color: selectedDay == index ? context.rTextColors.filledInputForm : context.themeColors.second,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            dayName,
            style: context.fonts.smallBody.copyWith(
              color: selectedDay == index ? context.rTextColors.filledInputForm : context.textColors.filledInputForm,
              fontWeight: selectedDay == index ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }
}
