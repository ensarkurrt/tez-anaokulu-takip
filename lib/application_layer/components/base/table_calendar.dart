import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarItem extends StatefulWidget {
  final Function(DateTime) onDayChanged;
  const TableCalendarItem({super.key, required this.onDayChanged});

  @override
  State<TableCalendarItem> createState() => _TableCalendarItemState();
}

class _TableCalendarItemState extends State<TableCalendarItem> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });

    widget.onDayChanged(day);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: "tr_TR",
      rowHeight: context.height * 0.045,
      headerStyle: HeaderStyle(
        titleTextStyle: context.fonts.title.copyWith(color: context.textColors.focusTitle),
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: IconPathEnums.leftCalendar.widget(height: context.height * 0.02),
        rightChevronIcon: IconPathEnums.rightCalendar.widget(height: context.height * 0.02),
      ),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      focusedDay: today,
      firstDay: DateTime.utc(2023, 11, 01),
      lastDay: DateTime.utc(2025, 12, 01),
      onDaySelected: _onDaySelected,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: context.themeColors.accent.withOpacity(.5),
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(color: context.textColors.description),
        outsideDaysVisible: false,
        selectedDecoration: BoxDecoration(
          color: context.themeColors.accent,
          shape: BoxShape.circle,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: context.textColors.filledInputForm, fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(color: context.textColors.description, fontWeight: FontWeight.bold),
      ),
    );
  }
}
