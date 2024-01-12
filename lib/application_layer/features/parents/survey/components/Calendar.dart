import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 5,
                blurRadius: 15,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 10))
          ]),
      child: TableCalendar(
        startingDayOfWeek: StartingDayOfWeek.monday,
        locale: "tr_TR",
        availableCalendarFormats: const {
          CalendarFormat.month: "Ay",
          CalendarFormat.week: "Hafta",
          CalendarFormat.twoWeeks: "2 Hafta"
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 145, 33).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.orangeAccent,
          ),
          formatButtonVisible: false,
          titleCentered: true,
        ),
        availableGestures: AvailableGestures.all,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
    );
  }
}