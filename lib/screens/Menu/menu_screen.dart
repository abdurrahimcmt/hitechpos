import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/food.dart';
import 'package:hitechpos/models/food_category.dart';

import 'package:hitechpos/screens/responsive/responsive_layout.dart';
import 'package:hitechpos/screens/Menu/component/category.dart';
import 'package:hitechpos/screens/cart_screen.dart';
import 'package:hitechpos/widgets/custom_drawer.dart';
import 'package:hitechpos/widgets/searchbox.dart';

class MenuScreen extends StatefulWidget {
 
  const MenuScreen({Key ?key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
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
          "Hi-Tech Pos",
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
      drawer: const CustomDrawer(),
      body: Row(
        children: [
      
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: Palette.bgGradient,
              ),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SearchBox(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver:SliverToBoxAdapter(
                      child: Cagetory(
                        categoryList : foodCategoryAll,
                      ),
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount: menuItemGridcrossAxisCount,
                    children: List.generate(foodlist.length, (index) {
                        Food food = foodlist[index];
                        return _buildMenuItem(food);
                    }
                   ),
                  ),
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