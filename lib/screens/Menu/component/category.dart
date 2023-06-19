import 'package:flutter/material.dart';
import 'package:hitechpos/models/food_category.dart';
import 'package:hitechpos/screens/Menu/component/create_category.dart';
class Cagetory extends StatelessWidget {
  final List<FoodCategory> categoryList;
  const Cagetory({Key?key, required this.categoryList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
        FoodCategory foodCategory = categoryList[index];
          return CreateCategory(
            categoryImage: foodCategory.imageUrl, 
            categoryName: foodCategory.catName,
            );
        },
      ),
    );
  }
}
