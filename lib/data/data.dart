import 'package:hitechpos/models/food.dart';
import 'package:hitechpos/models/food_category.dart';
import 'package:hitechpos/models/food_size.dart';
import 'package:hitechpos/models/order.dart';
import 'package:hitechpos/models/ordertype.dart';
import 'package:hitechpos/models/restaurant.dart';
import 'package:hitechpos/models/user.dart';
import '../models/modifier.dart';

enum SharedPreferencesKeys {
  vUserId,
  vFullName,
  dExpiryDate,
  vMobileNo,
  vEmailId,
  vEmployeeId,
  dLastLogin,
  loginBranch,
  loginUserName,
  loginPassword,
  rememberMe,
  autoLogin,
  schema,
  port,
  domain,
  registrationkey,
  isregistration,
  rendomNumberForOrderId
}

extension KeyValue on SharedPreferencesKeys {
  String get name {
    switch (this) {
      case SharedPreferencesKeys.vUserId:
        return 'vUserId';
      case SharedPreferencesKeys.vFullName:
        return 'vFullName';
      case SharedPreferencesKeys.dExpiryDate:
        return 'dExpiryDate';
      case SharedPreferencesKeys.vMobileNo:
        return 'vMobileNo';
      case SharedPreferencesKeys.vEmailId:
        return 'vEmailId';
      case SharedPreferencesKeys.vEmployeeId:
        return 'vEmployeeId';
      case SharedPreferencesKeys.dLastLogin:
        return 'dLastLogin';
      case SharedPreferencesKeys.rememberMe:
        return 'remember_me';
      case SharedPreferencesKeys.loginBranch:
        return 'branch_Id';
      case SharedPreferencesKeys.loginUserName:
        return 'username';
      case SharedPreferencesKeys.loginPassword:
        return 'password';
      case SharedPreferencesKeys.autoLogin:
        return 'autoLogin';
      case SharedPreferencesKeys.schema:
        return 'schema';
      case SharedPreferencesKeys.domain:
        return 'domain';
      case SharedPreferencesKeys.port:
        return 'port';
      case SharedPreferencesKeys.registrationkey:
        return 'registrationkey';
      case SharedPreferencesKeys.isregistration:
        return 'isregistration';
      case SharedPreferencesKeys.rendomNumberForOrderId:
        return 'rendomNumber';              
      default:
        return '';
    }
  }
}

List<Ordertype> orderTypes = [
  Ordertype(
    imageUrl: "assets/images/dining-table.png",
    name: "Dine In"
  ),
  Ordertype(
    imageUrl: "assets/images/take-away.png",
    name: "Take Away"
  ),
  Ordertype(
    imageUrl: "assets/images/fast-delivery.png",
    name: "Delivery"
  ),
  Ordertype(
    imageUrl: "assets/images/car.png",
    name: "Drive Through"
  ),
  ];
final List<FoodCategory> foodCategoryAll = [
  FoodCategory(
    catid: 1,
    catName: "Burger",
    imageUrl: "assets/images/1.png",
    menu: [_steak, _pasta, _ramen, _pancakes, _burger, _pizza],
  ),
  FoodCategory(
    catid: 2,
    catName: "Pizza",
    imageUrl: "assets/images/2.png",
    menu: [_steak, _pasta, _pancakes, _burger, _pizza, _salmon],
  ),
  FoodCategory(
    catid: 3,
    catName: "Chicken",
    imageUrl: "assets/images/3.png",
    menu: [_steak, _pasta, _pancakes, _burger, _pizza, _salmon],
  ),
  FoodCategory(
    catid: 4,
    catName: "Spagethi",
    imageUrl: "assets/images/4.png",
    menu: [_burrito, _ramen, _pancakes, _salmon],
  ),
  FoodCategory(
    catid: 5,
    catName: "Burger",
    imageUrl: "assets/images/1.png",
    menu: [_steak, _pasta, _ramen, _pancakes, _burger, _pizza]
  ),
  FoodCategory(
    catid: 6,
    catName: "Pizza",
    imageUrl: "assets/images/2.png",
    menu: [_burrito, _ramen, _pancakes, _salmon],
  ),
  FoodCategory(
    catid: 7,
    catName: "Chicken",
    imageUrl: "assets/images/3.png",
    menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
  ),
  FoodCategory(
    catid: 8,
    catName: "Spagethi",
    imageUrl: "assets/images/4.png",
    menu: [_burrito, _ramen, _pancakes, _salmon],
  ),
  FoodCategory(
    catid: 9,
    catName: "Burger",
    imageUrl: "assets/images/1.png",
    menu: [_burrito, _ramen, _pancakes, _salmon],
  ),
  FoodCategory(
    catid: 10,
    catName: "Pizza",
    imageUrl: "assets/images/2.png",
    menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
  ),
  FoodCategory(
    catid: 11,
    catName: "Chicken",
    imageUrl: "assets/images/3.png",
    menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
  ),
  FoodCategory(
    catid: 12,
    catName: "Spagethi",
    imageUrl: "assets/images/4.png",
    menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
  )
];

final List<Food> foodlist = [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon];
 List<FoodSize> foodSizeList = [
    FoodSize(sizeId: 1, sizeName: "Mini", price: 2.00),
    FoodSize(sizeId: 1, sizeName: "Small", price: 5.00),
    FoodSize(sizeId: 1, sizeName: "Large", price: 10.00),
    FoodSize(sizeId: 1, sizeName: "E Large", price: 19.00)
];

List<String> kitchenNotes = ["Extra Sauce", "Medium Spicy", "No Oil", 
                            "Spicy","No Sauce","Rare","Medium Rare",
                            "Medium","Medium Well","Well Done","Extra Chicken"];

List<String> invoiceNotes = ["After 1 Hour","After Noon","Evening","Tomorrow Dinner","Today Lunch"];
List<String> floors = ["Floor 1","Floor 2","Floor 3","Floor 4","Floor 5"];
List<String> tables = ["Table 1","Table 2","Table 3","Table 4","Table 5",
"Table 6","Table 7","Table 8","Table 9","Table 10","Table 11","Table 12",
"Table 13","Table 14","Table 15","Table 16","Table 17","Table 18","Table 19",
"Table 20","Table 21","Table 22","Table 23"];

//List<String> selectedTables = ["Table 5","Table 9","Table 16","Table 20","Table 23"];

final List<Modifier> modifierList = [
  Modifier(imageUrl: 'assets/images/CocaCola.jpg', name: 'Coca Cola', price: 8.00, discription: 'variations'),
  Modifier(imageUrl: 'assets/images/extracheese.jpg', name: 'Cheese', price: 8.00, discription: 'variations'),
  Modifier(imageUrl: 'assets/images/LemonDrinks.jpg', name: 'Mayonnaise', price: 17.00, discription: 'variations'),
  Modifier(imageUrl: 'assets/images/FruitDrinks.jpg', name: 'Fruit D', price: 14.00, discription: 'variations'),
  Modifier(imageUrl: 'assets/images/LemonDrinks.jpg', name: 'Lemon D', price: 13.00, discription: 'variations'),
  Modifier(imageUrl: 'assets/images/OrangeDrinks.jpg', name: 'Orange D', price: 13.00, discription: 'variations'),
  Modifier(imageUrl: 'assets/images/Pepsi.jpg', name: 'Pepsi', price: 13.00, discription: 'variations'),
];
final _burrito =
    Food(imageUrl: 'assets/images/burrito.jpg', name: 'Burrito', price: 8.00, discription: 'here are many variations');
final _steak =
    Food(imageUrl: 'assets/images/steak.jpg', name: 'Steak', price: 17.00, discription: 'here are many variations');
final _pasta =
    Food(imageUrl: 'assets/images/pasta.jpg', name: 'Pasta', price: 14.00, discription: 'here are many variations');
final _ramen =
    Food(imageUrl: 'assets/images/ramen.jpg', name: 'Ramen', price: 13.00, discription: 'here are many variations');
final _pancakes =
    Food(imageUrl: 'assets/images/pancakes.jpg', name: 'Pancakes', price: 9.00, discription: 'here are many variations');
final _burger =
    Food(imageUrl: 'assets/images/burger.jpg', name: 'Burger', price: 14.00, discription: 'here are many variations');
final _pizza =
    Food(imageUrl: 'assets/images/pizza.jpg', name: 'Pizza', price: 11.00, discription: 'here are many variations');
final _salmon = Food(
    imageUrl: 'assets/images/salmon.jpg', name: 'Salmon Salad', price: 12.00, discription: 'here are many variations');

// Restaurants
final _restaurant0 = Restaurant(
  imageUrl: 'assets/images/restaurant0.jpg',
  name: 'Category1',
  address: '200 Main St, New York, NY',
  rating: 5,
  menu: [_burrito, _steak, _pasta, _ramen, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant1 = Restaurant(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Category1',
  address: '200 Main St, New York, NY',
  rating: 4,
  menu: [_steak, _pasta, _ramen, _pancakes, _burger, _pizza],
);
final _restaurant2 = Restaurant(
  imageUrl: 'assets/images/restaurant2.jpg',
  name: 'Restaurant 2',
  address: '200 Main St, New York, NY',
  rating: 4,
  menu: [_steak, _pasta, _pancakes, _burger, _pizza, _salmon],
);
final _restaurant3 = Restaurant(
  imageUrl: 'assets/images/restaurant3.jpg',
  name: 'Restaurant 3',
  address: '200 Main St, New York, NY',
  rating: 2,
  menu: [_burrito, _steak, _burger, _pizza, _salmon],
);
final _restaurant4 = Restaurant(
  imageUrl: 'assets/images/restaurant4.jpg',
  name: 'Restaurant 4',
  address: '200 Main St, New York, NY',
  rating: 3,
  menu: [_burrito, _ramen, _pancakes, _salmon],
);

final List<Restaurant> restaurants = [
  _restaurant0,
  _restaurant1,
  _restaurant2,
  _restaurant3,
  _restaurant4,
];

// User
final currentUser = User(
  name: 'Rebecca',
  orders: [
    Order(
      date: 'Nov 10, 2019',
      food: _steak,
      restaurant: _restaurant2,
      quantity: 1,
    ),
    Order(
      date: 'Nov 8, 2019',
      food: _ramen,
      restaurant: _restaurant0,
      quantity: 3,
    ),
    Order(
      date: 'Nov 5, 2019',
      food: _burrito,
      restaurant: _restaurant1,
      quantity: 2,
    ),
    Order(
      date: 'Nov 2, 2019',
      food: _salmon,
      restaurant: _restaurant3,
      quantity: 1,
    ),
    Order(
      date: 'Nov 1, 2019',
      food: _pancakes,
      restaurant: _restaurant4,
      quantity: 1,
    ),
  ],
  cart: [
    Order(
      date: 'Nov 11, 2019',
      food: _burger,
      restaurant: _restaurant2,
      quantity: 2,
    ),
    Order(
      date: 'Nov 11, 2019',
      food: _pasta,
      restaurant: _restaurant2,
      quantity: 1,
    ),
        Order(
      date: 'Nov 11, 2019',
      food: _pasta,
      restaurant: _restaurant2,
      quantity: 1,
    ),
        Order(
      date: 'Nov 11, 2019',
      food: _pasta,
      restaurant: _restaurant2,
      quantity: 1,
    ),
        Order(
      date: 'Nov 11, 2019',
      food: _pasta,
      restaurant: _restaurant2,
      quantity: 1,
    ),
        Order(
      date: 'Nov 11, 2019',
      food: _pasta,
      restaurant: _restaurant2,
      quantity: 1,
    ),
    Order(
      date: 'Nov 11, 2019',
      food: _salmon,
      restaurant: _restaurant3,
      quantity: 1,
    ),
    Order(
      date: 'Nov 11, 2019',
      food: _pancakes,
      restaurant: _restaurant4,
      quantity: 3,
    ),
    Order(
      date: 'Nov 11, 2019',
      food: _burrito,
      restaurant: _restaurant1,
      quantity: 2,
    ),
  ],
);
