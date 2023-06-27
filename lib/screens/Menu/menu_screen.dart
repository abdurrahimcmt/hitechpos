import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/food.dart';
import 'package:hitechpos/screens/order/order_screen.dart';
import 'package:hitechpos/screens/menu/component/category.dart';
import 'package:hitechpos/screens/cart_screen.dart';
import 'package:hitechpos/widgets/searchbox.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key ?key}) : super(key: key);
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String currentItem = "";
  int selectedOrderType = 0;
  
  @override
  void initState(){
    currentItem = orderTypes[0].name;
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
            fontSize: Palette.contentTitleFontSize,
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
                fontSize: Palette.contentTitleFontSize,
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
                Cagetory(categoryList : foodCategoryAll,),
                const SizedBox(
                  height: 10,
                ),
                //Menu work Start
                  Center(
                    child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 2,
                        children: List.generate(foodlist.length, (index) {
                          return TextButton(
                              onPressed: () => Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (_) => OrderScreen(food: foodlist[index]),
                              ),
                            ), 
                            child: _buildMenuItem(foodlist[index]),
                          );
                        }),
                        ),
                      ),
                    ],
                    ),
                  ),
              ],
            ),
          ),
      ),
    );
  }

  _buildMenuItem(Food MenuItem) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MenuItem.imageUrl),
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
                MenuItem.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: Palette.layoutFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Palette.menuFoodNameFontSize
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\$${MenuItem.price}',
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
        return Container(

        );
      }
    );
  }
}