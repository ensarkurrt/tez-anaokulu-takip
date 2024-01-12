import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/foodlist/components/food_list_tab_component.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/food_list_item_model.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

class FoodTabItem extends StatefulWidget {
  final List<FoodListItemModel> items;
  const FoodTabItem({super.key, required this.items});

  @override
  State<FoodTabItem> createState() => _FoodTabItemState();
}

class _FoodTabItemState extends State<FoodTabItem> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        /* shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), */
        children: [
          TabBar(
            unselectedLabelColor: context.textColors.deactiveInput,
            labelColor: context.textColors.filledInputForm,
            indicatorColor: context.themeColors.accent,
            indicatorWeight: context.height * 0.002,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: context.fonts.body,
            tabs: [
              TabWidget("Kahvaltı"),
              TabWidget("Öğlen Yemeği"),
              TabWidget("İkindi Yemeği"),
            ],
          ),
          Container(
            margin: PaddingEnums.pagePaddingHalf.vertical(context),
            height: context.height * 0.45,
            child: TabBarView(
              children: [
                pagebuilder(
                  widget.items
                      .where((element) =>
                          element.timeEnum == FoodListTimeEnum.Breakfast)
                      .toList(),
                ),
                pagebuilder(
                  widget.items
                      .where((element) =>
                          element.timeEnum == FoodListTimeEnum.MorningFood)
                      .toList(),
                ),
                pagebuilder(
                  widget.items
                      .where((element) =>
                          element.timeEnum == FoodListTimeEnum.AfternoonFood)
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TabWidget(String title) {
    return Tab(
      child: SizedBox(
        child: Text(
          title,
          style: context.fonts.smallBody.copyWith(
              color: context.textColors.filledInputForm,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget pagebuilder(List<FoodListItemModel> items) {
    return Padding(
      padding: PaddingEnums.pagePadding.horizontal(context),
      child: ListView(
        children: [
          Column(
            children: [
              FoodListItemComponent(items: items),
            ],
          ),
        ],
      ),
    );
  }
}
