import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/food.dart';
import 'package:hitechpos/screens/order/order_screen.dart';
import 'package:hitechpos/screens/responsive/responsive_layout.dart';
import 'package:hitechpos/screens/menu/component/category.dart';
import 'package:hitechpos/screens/cart_screen.dart';
import 'package:hitechpos/widgets/custom_drawer.dart';
import 'package:hitechpos/widgets/searchbox.dart';

class MenuScreen extends StatefulWidget {
 
  const MenuScreen({Key ?key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String currentItem = "";
  
  @override
  void initState(){
    currentItem = orderTypes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    int  menuItemGridcrossAxisCount = ResponsiveLayout.isDesktop(context) ? 7 : 
    ResponsiveLayout.isTablet(context) ? 3 : 
    ResponsiveLayout.isMTablet(context) ? 4 :
    ResponsiveLayout.isLTablet(context) ? 5 :
    ResponsiveLayout.ismobile(context) ? 2 :
    ResponsiveLayout.isLMobile(context) ? 3 : 2;
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Palette.bgColorPerple,
        centerTitle: true,
        title: const Text(
          "HIPOS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: Palette.bgGradient,
              ),
              child: CustomScrollView(
                slivers: [
                  //Order Type Work start
                  SliverToBoxAdapter(
                    
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.iconBackgroundColorPurple,width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.iconBackgroundColorPurple, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                              ),
                              dropdownColor: Colors.white,
                              value: currentItem,
                              items: orderTypes.
                              map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                                value: e,
                                alignment: Alignment.center,
                                child: Text(e),
                                ),
                              ).toList(),
                              onChanged: (String? value) => setState(() {
                               if(value!=null) currentItem = value; 
                                },
                              ),
                            ),
                            SearchBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Order Type Work End
                  //Category Work start
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver:SliverToBoxAdapter(
                      child: Cagetory(
                        categoryList : foodCategoryAll,
                      ),
                    ),
                  ),
                  //Category Work End
                  //Menu Work Start 
                  SliverGrid.count(
                    crossAxisCount: menuItemGridcrossAxisCount,
                    children: List.generate(foodlist.length, (index) {
                        Food food = foodlist[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (_) => OrderScreen(food: food,),
                            ),
                          ),
                          child: _buildMenuItem(food),
                      );
                    }
                   ),
                  ),
                  // Menu Work End
                ],
              ),
            )
          ),
          // Right        
        ],
      ),
    );
  }

  _buildMenuItem(Food MenuItem) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MenuItem.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
            bottom: 65.0,
            child: Column(
              children: [
                Text(
                  MenuItem.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${MenuItem.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              width: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: Palette.btnGradientColor,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}