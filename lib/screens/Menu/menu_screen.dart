import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/categoryWithItemList.dart';
import 'package:hitechpos/screens/menu/component/create_category.dart';
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
  late Future<CategoryWithItemList> categoryWithItemList;
  @override
  void initState(){
    currentItem = orderTypes[0].name;
    categoryWithItemList = fatchCategoryWithItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Palette.bgColorPerple,
        centerTitle: true,
        title: const Text(
          "HIPOS",
          style: TextStyle(
            color: Colors.white,
            fontSize: Palette.contentTitleFontSizeL,
          ),
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
                fontSize: Palette.btnFontsize,
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
                              _buildModelBottomSheet();
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
                                fit: BoxFit.cover,),
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
                    const CircularProgressIndicator();
                    return Text('${snapshot.error}');
                  }
                }),
                //Cagetory(categoryList : foodCategoryAll,),
                const SizedBox(
                  height: 10,
                ),
                //Menu work Start
                  Center(
                    child: FutureBuilder<CategoryWithItemList>(
                      future: fatchCategoryWithItemList(),
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
                          return Text('${snapshot.error}');
                        }
                      }),
                      
                    ),
                  ),
              ],
            ),
          ),
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
                '\$${MenuItem.vItemPrice}',
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
  _buildModelBottomSheet(){
    return showModalBottomSheet(
      context: context, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )
      ),
      builder: (BuildContext context){
        Size size = MediaQuery.of(context).size;
        return Container(
          height: size.height* 0.9,
        );
      }
    );
  }
}

Future<CategoryWithItemList> fatchCategoryWithItemList() async {
  final response = await http.get(Uri.parse("http://hiposbh.com:84/api/AppsAPI/online/08f4f0d8-ddf4-4498-b878-2c69eec6452e/all/all/all"));
  if(response.statusCode == 200){
      return CategoryWithItemList.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load Category');
  }
}