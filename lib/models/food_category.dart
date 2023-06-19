import 'package:hitechpos/models/food.dart';

class FoodCategory{
    late int catid;
    late String catName;
    late String imageUrl;
    FoodCategory(
      {
        required this.catid,
        required this.catName,
        required this.imageUrl, required List<Food> menu
      }
    );
}