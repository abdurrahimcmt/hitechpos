import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hitechpos/common/palette.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return  NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Palette.bgColorPerple,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontFamily: Palette.layoutFont,
            fontSize: Palette.bottomNavigationBarFontSize,
            fontWeight: FontWeight.w500,
            color: Palette.textColorPurple,
          ),
        ),
      ),
      child: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            label: "Dashboard"
          ),
          
          NavigationDestination(
            icon: Icon(Icons.shopping_basket), 
            label: "Cart"
          ),
    
          NavigationDestination(
            icon: Icon(Icons.account_circle), 
            label: "Profile"
          ),
    
          NavigationDestination(
            icon: Icon(Icons.list), 
            label: "Order List"
          ),
        ]
      ),
    );
  }
}