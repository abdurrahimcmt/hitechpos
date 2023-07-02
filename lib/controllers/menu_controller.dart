import 'package:get/get.dart';
import 'package:hitechpos/models/food.dart';

class MenuController extends GetxController{
  Rx<Food> selectedFood = Food(discription: '', imageUrl: '', name: '', price: 0.00).obs;
  void setSelectedFood(Food food){
    selectedFood.value = food;
  }
}