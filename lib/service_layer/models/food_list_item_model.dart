class FoodListItemModel {
  final String foodname;
  final int calories;
  final FoodListTimeEnum timeEnum;
  final DateTime dateTime;

  FoodListItemModel({
    required this.calories,
    required this.foodname,
    required this.timeEnum,
    required this.dateTime,
  });
}

enum FoodListTimeEnum { Breakfast, MorningFood, AfternoonFood }
