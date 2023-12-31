import 'package:flutter/material.dart';

class Palette{
  //Common for whole layout
  static const layoutFont = "Lato";
  static const bottomNavigationBarFontSize = 12.00;
  static const sheetTitleFontsize = 16.00;
  static const btnFontsize = 16.00;
  static const contentTitleFontSize = 12.0;
  static const contentTitleFontSizeL = 15.0;
  static const discriptionFontSize = 10.0;
  static const discriptionFontSizeL = 12.0;
  static const containerButtonFontSize = 10.0;
  static const containerButtonFontSizeL = 12.0;
  static const menuFoodNameFontSize = 10.0;
  static const menuFoodNameFontSizeL = 12.0;
  static const sizeBoxVarticalSpace = SizedBox(
    height: 15,
  );
  static const fontBgGray = Color(0xff6d6d6d);
  static const btnBoxShadowColor = Color(0x7caa68d2);
  static const textColorLightPurple = Color.fromARGB(255, 89, 73, 95);

  static const LinearGradient welcomeBg = LinearGradient(
    colors: [Color(0x00fffafb), Color(0x00f3dcff)],
  );

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter, 
    end: Alignment.bottomCenter, 
    colors: [Color(0xfffff8fa), Color(0xfff5e3ff)], 
  );

  static const btnGradientColor = LinearGradient(
    begin: Alignment.centerLeft, 
    end: Alignment.centerRight, 
    colors: [Color(0xff780ea1), Color(0xff530073)], 
    );

  static const btnGradientColorLight = LinearGradient(colors: [
    Color.fromARGB(255, 246, 222, 255),Color.fromARGB(255, 230, 213, 236),
  ]);

  static const onBoardingBoxGradient = LinearGradient(colors: [
      Color.fromARGB(255, 241, 96, 137),Color.fromARGB(255, 169, 104, 210),
  ]);

  static const bgColorPerple = Color.fromARGB(255, 83, 1, 116);
  static const btnTextColor = Colors.white;
  static const btnFontWeight = FontWeight.w700;
  static const iconBackgroundColorPurple = Color.fromARGB(255, 83, 1, 116);
  static const textColorPurple = bgColorPerple;
  static const textBackGroundBlack = Color.fromARGB(255, 0, 0, 0);


/// text container decoration 
  static const textContainerBorderRadius =  BorderRadius.all(Radius.circular(5));
///Container curb style
  static const containerCurbBoxdecoration = 
  BoxDecoration(
    color: Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40),
      topRight: Radius.circular(40),
    ),
    boxShadow: [
      BoxShadow(
      color: Palette.btnBoxShadowColor,
      spreadRadius: 5,
      blurRadius: 2,
      offset: Offset(0, 2),
      )
   ],
  );
}