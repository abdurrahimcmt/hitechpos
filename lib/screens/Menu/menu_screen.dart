import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/categoryWithItemList.dart';
import 'package:hitechpos/screens/dashboard/dashboard_screen.dart';
import 'package:hitechpos/screens/menu/component/create_category.dart';
import 'package:hitechpos/screens/menu/component/delivery_screen.dart';
import 'package:hitechpos/screens/menu/component/dine_in.dart';
import 'package:hitechpos/screens/menu/component/drive_through.dart';
import 'package:hitechpos/screens/menu/component/take_away.dart';
import 'package:hitechpos/screens/order/order_screen.dart';
import 'package:hitechpos/widgets/searchbox.dart';
import 'package:http/http.dart' as http;
import '../cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key ?key}) : super(key: key);
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String currentItem = "";
  int selectedOrderType = 0;
  late Size size;
  late Future<CategoryWithItemList> categoryWithItemList;
  List<String> isSelectedTabels = <String>[];
  @override
  void initState(){
    currentItem = orderTypes[0].name;
    categoryWithItemList = fatchCategoryWithItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size= MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const DashboardScreen());
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
              Get.offAll(const DashboardScreen());
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              ),
              child: Text(
                'Cart  (${currentUser.cart.length})',
                style: const TextStyle(
                  color: Colors.white,
                ),
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
                        return TextButton(
                            onPressed: (){
                              setState(() {
                                _buildModelBottomSheet(orderTypes[index].name);
                                selectedOrderType = index;
                              });
                            }, 
                            child: Container(
                              width: size.width < 800 ? size.width * 0.20 : size.width * 0.23,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: selectedOrderType == index? Palette.btnGradientColor : Palette.bgGradient,
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
                                  fit: BoxFit.fitWidth,),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: FittedBox(
                                      child: Text(orderTypes[index].name,
                                            style: TextStyle(
                                              fontFamily: Palette.layoutFont,
                                              fontSize: Palette.containerButtonFontSize,
                                              fontWeight: FontWeight.bold,
                                              color: selectedOrderType == index? Colors.white: Palette.textColorLightPurple,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              ),
                            );
                      }),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20 , right: 20),
                    child: SearchBox(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Category Work Start
                  FutureBuilder<CategoryWithItemList>(
                    future: categoryWithItemList,
                    builder: (context, snapshot){
                    if(snapshot.hasData){
                      return SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.onlineCatWithItemLists.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                          OnlineCatWithItemList foodCategory = snapshot.data!.onlineCatWithItemLists[index];
                            return CreateCategory(
                              categoryImage: "", 
                              categoryName: foodCategory.vCategoryName,
                              );
                          },
                        ),
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                  //Cagetory(categoryList : foodCategoryAll,),
                  const SizedBox(
                    height: 10,
                  ),
                  //Menu work Start
                    SizedBox(
                      child: Center(
                        child: FutureBuilder<CategoryWithItemList>(
                          future: categoryWithItemList,
                          builder: ((context, snapshot) {
                            if(snapshot.hasData){
                              return Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                    alignment: WrapAlignment.center,
                                    direction: Axis.horizontal,
                                    spacing: 0,
                                    runSpacing: 2,
                                    children: List.generate(snapshot.data!.onlineCatWithItemLists.first.onlineItemLists.length, (index) {
                                      return TextButton(
                                          onPressed: () => Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (_) => OrderScreen(food: snapshot.data!.onlineCatWithItemLists.first.onlineItemLists[index]),
                                          ),
                                        ), 
                                        child: _buildMenuItem(snapshot.data!.onlineCatWithItemLists.first.onlineItemLists[index]),
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
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            }
                          }),
                          
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

  _buildMenuItem(OnlineItemList MenuItem) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(MenuItem.vImagePath,),
              fit: BoxFit.cover,
            ),
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
              Text(
                MenuItem.vItemName,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: Palette.layoutFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Palette.menuFoodNameFontSize
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                MenuItem.vItemPrice,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: Palette.layoutFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Palette.menuFoodNameFontSize
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
  _buildModelBottomSheet(String name){
    return showModalBottomSheet(
      
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
          return DriveThroughScreen();
        }
      }
    );
  }
}

Future<CategoryWithItemList> fatchCategoryWithItemList() async {
  final response = await http.get(Uri.parse("https://hiposbh.com:84/api/AppsAPI/online/08f4f0d8-ddf4-4498-b878-2c69eec6452e/all/all/all"));
  if(response.statusCode == 200){
      return CategoryWithItemList.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load Category');
  }
}