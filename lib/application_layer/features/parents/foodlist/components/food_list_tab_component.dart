import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/food_list_item_model.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';
import 'package:kindergarden_mobile/tools/enums/radius_enums.dart';

class FoodListItemComponent extends StatefulWidget {
  final List<FoodListItemModel> items;
  const FoodListItemComponent({super.key, required this.items});

  @override
  State<FoodListItemComponent> createState() => _FoodListItemComponentState();
}

class _FoodListItemComponentState extends State<FoodListItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: widget.items.map((e) => ListRow(e)).toList());
  }

  // ignore: non_constant_identifier_names
  Widget ListRow(FoodListItemModel item) {
    return Column(
      children: [
        Container(
          width: context.width * 1,
          height: context.height * 0.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
            borderRadius: RadiusEnums.general.all(context),
            color: context.themeColors.main,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FoodIcon(),
              FoodName(item.foodname),
              FoodCalories(item.calories),
            ],
          ),
        ),
        context.addVerticalSpace(0.02)
      ],
    );
  }

  Padding FoodIcon() {
    return Padding(
      padding: PaddingEnums.cardPadding.vertical(context),
      child: Row(
        children: [
          context.addHorizontalSpace(context.width * 0.00008),
          IconPathEnums.food.widget(height: context.height * 0.065),
        ],
      ),
    );
  }

  Center FoodCalories(int calories) {
    return Center(
      child: Row(
        children: [
          Container(
            width: context.width * 0.22,
            height: context.height * 0.049,
            decoration: BoxDecoration(
              borderRadius: RadiusEnums.general.all(context),
              border: Border.all(
                color: context.textColors.error,
                width: 0.8,
              ),
            ),
            child: Center(
              child: Text(
                "$calories Kcal",
                style: context.fonts.body.copyWith(
                    color: context.textColors.error,
                    fontSize: context.height * 0.015),
              ),
            ),
          ),
          context.addHorizontalSpace(0.03)
        ],
      ),
    );
  }

  Center FoodName(String foodname) {
    return Center(
      child: Text(
        foodname,
        style: context.fonts.body
            .copyWith(color: context.textColors.filledInputForm),
      ),
    );
  }
}
