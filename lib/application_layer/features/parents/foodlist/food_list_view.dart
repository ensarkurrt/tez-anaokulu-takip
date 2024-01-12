import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/foodlist/components/food_tab_controller.dart';
import 'package:kindergarden_mobile/application_layer/components/base/table_calendar.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/foodlist/food_data/food_data.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:table_calendar/table_calendar.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({super.key});

  @override
  State<FoodListView> createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  DateTime focusedDay = DateTime.now();

  void onDayChanged(DateTime day) {
    setState(() {
      focusedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Yemek Listesi",
          ),
        ),
        body: PageLayout(
          child: Column(
            children: [
              TableCalendarItem(onDayChanged: onDayChanged),
              FoodTabItem(
                items: FoodData()
                    .foods
                    .where((element) => isSameDay(element.dateTime, focusedDay))
                    .toList(), // focusedDay ile foods'ta ki yemeğin dateTime'ı eşitse liste de gösterir.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
