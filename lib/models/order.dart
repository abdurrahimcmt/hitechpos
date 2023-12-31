import 'package:hitechpos/models/restaurant.dart';

import 'food.dart';

class Order {
  final Restaurant restaurant;
  final Food food;
  final String date; 
  int quantity;

  Order({
    required this.date,
    required this.restaurant,
    required this.food,
    required this.quantity,
  });
}
