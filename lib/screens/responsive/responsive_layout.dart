import 'package:flutter/material.dart';

class ResponsiveLayout{

  static bool ismobile(BuildContext context) => 
      MediaQuery.of(context).size.width > 400 &&
      MediaQuery.of(context).size.width <= 500;

    static bool isLMobile(BuildContext context) => 
      MediaQuery.of(context).size.width > 501 && 
      MediaQuery.of(context).size.width <= 600;   

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >600 &&
      MediaQuery.of(context).size.width <= 800;

  static bool isMTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >800 &&
      MediaQuery.of(context).size.width <= 1000;
 
 static bool isLTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >1000 &&
      MediaQuery.of(context).size.width <= 1200;


  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;
}