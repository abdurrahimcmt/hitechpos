import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/categoryInfo.dart';
import 'package:hitechpos/models/categoryWithItemList.dart';
import 'package:hitechpos/models/iteminfo.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import 'package:hitechpos/views/menu/component/create_category.dart';
import 'package:hitechpos/views/menu/component/delivery_screen.dart';
import 'package:hitechpos/views/menu/component/dine_in.dart';
import 'package:hitechpos/views/menu/component/drive_through.dart';
import 'package:hitechpos/views/menu/component/take_away.dart';
import 'package:hitechpos/views/order/order_screen.dart';
import 'package:http/http.dart' as http;
import '../cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class MenuScreen extends GetView<MenuScreenController> {
 MenuScreen({Key ?key}) : super(key: key);
  final cartController = Get.find<CartController>();
  //final loginController = Get.find<LoginController>();
  // final menuController = Get.find<MenuScreenController>();
  //String currentItem = "";
  //late Future<CategoryWithItemList> categoryWithItemList = fatchCategoryWithItemList("all","all","all");
  
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    //when user click on mobile back button then it will works
    return WillPopScope(
      onWillPop: () async {
        Get.to(const DashboardScreen());
        return true;
      },
      child: Scaffold(
         appBar: AppBar(
          backgroundColor: Palette.bgColorPerple,
          centerTitle: true,
          title: const Text(
            "HIPOS",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.to(const DashboardScreen());
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.to(const CartScreen()),
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const CartScreen(),
              //   ),
              // ),
              // child: Text(
              //   'Cart  (${currentUser.cart.length})',
              //   style: const TextStyle(
              //     color: Colors.white,
              //   ),
              // ),
              child: badges.Badge(
                badgeContent: Text(
                  cartController.cartDetailsModelList.value.length.toString(),
                  style: const TextStyle(
                  color: Colors.white,
                  ),
                ), 
                child: const Icon(Icons.shopping_cart,color: Colors.white,),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          //Order Type Work start
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(orderTypes.length, (index) {
                        return Obx(
                          () => TextButton(
                              onPressed: (){
                                controller.setSelectedOrderType(index);
                                _buildModelBottomSheet(orderTypes[index].name,context);
                                // setState(() {
                                //   _buildModelBottomSheet(orderTypes[index].name);
                                //   selectedOrderType = index;
                                // });
                              }, 
                              child: Container(
                                width: size.width < 800 ? size.width * 0.20 : size.width * 0.23,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: controller.selectedOrderType.value == index? Palette.btnGradientColor : Palette.bgGradient,
                                  borderRadius: Palette.textContainerBorderRadius,
                                  border: Border.all(
                                    color: Palette.btnBoxShadowColor,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                      Image(image: AssetImage(orderTypes[index].imageUrl),
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: FittedBox(
                                        child: Text(orderTypes[index].name,
                                              style: TextStyle(
                                                fontFamily: Palette.layoutFont,
                                                fontSize: Palette.containerButtonFontSize,
                                                fontWeight: FontWeight.bold,
                                                color: controller.selectedOrderType.value == index? Colors.white: Palette.textColorLightPurple,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                              ),
                        );
                      }),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Search Work start
                  Padding(
                    padding: const EdgeInsets.only(left: 20 , right: 20),
                    child: TextField(
                      controller: controller.searchTextEditingController,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          controller.fatchItemInfo("all",value);
                          // setState(() {
                          //   categoryWithItemList =fatchCategoryWithItemList("all","all",value);
                          // });
                        }
                        else{
                          controller.fatchItemInfo("all","all");
                          // setState(() {
                          //   categoryWithItemList =fatchCategoryWithItemList("all","all","all");
                          // });
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical:15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(width: 0.5),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.fatchItemInfo("all","all");
                              controller. searchTextEditingController.text = "";
                              // setState(() {
                              //   menuController. searchTextEditingController.text = "";
                              //   categoryWithItemList =fatchCategoryWithItemList("all","all","all");
                              // });
                            },
                            icon: const Icon(
                            Icons.clear,
                          ),
                        ),
                        hintText: "Search here",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 237, 227, 238),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Palette.iconBackgroundColorPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Category Work Start
                  FutureBuilder<CategoryInfo>(
                    future: controller.categoryInfoList,
                    builder: (context, snapshot){
                    if(snapshot.hasData){
                      return SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.categoryList.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                          CategoryList foodCategory = snapshot.data!.categoryList[index];
                            return TextButton(
                              onPressed: () {
                                debugPrint(foodCategory.vCategoryId);
                                controller.selectedCategoryName.value = foodCategory.vCategoryName;
                                controller.fatchItemInfo(foodCategory.vCategoryId,"all");
                                // setState(() {
                                //   debugPrint(foodCategory.vCategoryId);
                                //   itemInfoList =fatchItemInfo(foodCategory.vCategoryId);
                                //   selectedCategoryName = foodCategory.vCategoryName;
                                // });
                              },
                              child: CreateCategory(
                                categoryImage: "", 
                                categoryName: foodCategory.vCategoryName,
                                ),
                            );
                          },
                        ),
                      );
                    }
                    else if(snapshot.hasError){
                      return SnackBar( content: Text("${snapshot.error}"),);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                  ),
                  //Cagetory(categoryList : foodCategoryAll,),
                  const SizedBox(
                    height: 10,
                  ),
                  //Menu work Start
                  SizedBox(
                    child: Center(
                      child: Obx(() {
                          final itemInfo = controller.itemInfo.value;
                            if(controller.itemInfoIsloading.value){
                              return const Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              );
                            }
                            else{
                              if(itemInfo.itemList.isNotEmpty){
                              return Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                    alignment: WrapAlignment.center,
                                    direction: Axis.horizontal,
                                    spacing: 0,
                                    runSpacing: 2,
                                    children: List.generate(itemInfo.itemList.length, (index) {
                                      return TextButton(
                                          onPressed: () {
                                            Get.to(() => const OrderScreen() ,arguments: itemInfo.itemList[index].vItemId);
                                          }, 
                                          // Navigator.push(
                                          //   context, 
                                          //   MaterialPageRoute(builder: (_) => OrderScreen(food: itemInfo.itemList[index]),
                                          //   ),
                                          // ), 
                                        child: _buildMenuItem(itemInfo.itemList[index]),
                                      );
                                    }),
                                    ),
                                  ),
                                ],
                              );
                            }
                            else{
                              return const SizedBox(
                                height: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Sorry, no item found",
                                      style: TextStyle(
                                        fontFamily: Palette.layoutFont,
                                        fontSize: Palette.contentTitleFontSizeL,
                                        fontWeight: FontWeight.w700,
                                        color: Palette.textColorLightPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                             }
                            }
                            
                            }
                          ),
                        
                      ),
                    ),
                ],
              ),
            ),
        ),
        //bottomNavigationBar: const BottomNavigationBarCustom(),
      ),
    );
  }

  _buildMenuItem(ItemList menuItem) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: NetworkImage("https://images.unsplash.com/photo-1610970878459-a0e464d7592b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=924&q=80"),
            //   //image: NetworkImage(menuItem.vImagePath,),
            //   fit: BoxFit.cover,
            // ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black87.withOpacity(0.3),
                Colors.black54.withOpacity(0.3),
                Colors.black38.withOpacity(0.3),
              ],
              stops: const [0.1, 0.4, 0.6, 0.9],
            ),
          ),
        ),
        Positioned(
          child: Column(
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  menuItem.vItemName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    //color: Palette.bgColorPerple,
                    fontFamily: Palette.layoutFont,
                    fontWeight: FontWeight.bold,
                    fontSize: Palette.menuFoodNameFontSizeL
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Text(
                menuItem.vItemPrice,
                style: const TextStyle(
                  //color: Palette.bgColorPerple,
                  color: Colors.white,
                  fontFamily: Palette.layoutFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Palette.menuFoodNameFontSizeL
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildModelBottomSheet(String name,BuildContext context){
    return  showModalBottomSheet(
      
      context: context, 
      isScrollControlled: true,
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        )
      ),
      builder: (BuildContext context){
        if(name == "Dine In"){
           
           return const DineInScreen();
        }
        else if(name == "Take Away"){
          return TakeAwayScreen();
        }
        else if(name == "Delivery"){
          return DeliveryScreen();
        }
        else{
          return const DriveThroughScreen();
        }
      }
    );
  }
}

Future<CategoryWithItemList> fatchCategoryWithItemList(String catid,String item,String searchText) async {
  final response = await http.get(Uri.parse("https://hiposbh.com:84/api/AppsAPI/online/08f4f0d8-ddf4-4498-b878-2c69eec6452e/$catid/$item/$searchText"));
  if(response.statusCode == 200){
      return CategoryWithItemList.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load Category');
  }
}

// Future<CategoryInfo> fatchCategoryInfo() async {
//   final loginController = Get.find<LoginController>();
//   String baseurl = loginController.baseurlFromLocalStorage;
//   final url = Uri.parse("${baseurl}api/waiterapp/category");
//   final headers = {
//     'Key': loginController.registrationKeyFromLocalStorage.toString(),
//     'Content-Type': 'application/json'
//     //'mbserial': '94-E9-79-CB-E9-A3',
//   };
//   final response = await http.get(url,headers: headers);
//   //final response = await http.get(Uri.parse("https://hiposbh.com:84/api/AppsAPI/online/08f4f0d8-ddf4-4498-b878-2c69eec6452e/$catid/$item/$searchText"));
//   if(response.statusCode == 200){
//       return CategoryInfo.fromJson(jsonDecode(response.body));
//   }
//   else{
//     throw Exception('Failed to load Category');
//   }
// }

// Future<ItemInfo> fatchItemInfo(String item) async {
//   final loginController = Get.find<LoginController>();
//   String baseurl = loginController.baseurlFromLocalStorage;
//   final url = Uri.parse("${baseurl}api/waiterapp/item/$item/");
//   final headers = {
//     'Key': loginController.registrationKeyFromLocalStorage.toString(),
//     'Content-Type': 'application/json'
//   };
//   final response = await http.get(url,headers: headers);
//   if(response.statusCode == 200){
//       return ItemInfo.fromJson(jsonDecode(response.body));
//   }
//   else{
//     throw Exception('Failed to load Item');
//   }
// }

// Future<CategoryWithItemList> fatchCategoryWithItemList() async {
//   final response = await http.get(Uri.parse("https://hiposbh.com:84/api/AppsAPI/online/08f4f0d8-ddf4-4498-b878-2c69eec6452e/all/all/all"));
//   if(response.statusCode == 200){
//       return CategoryWithItemList.fromJson(jsonDecode(response.body));
//   }
//   else{
//     throw Exception('Failed to load Category');
//   }
// }