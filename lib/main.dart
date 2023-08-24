import 'package:flutter/material.dart';
import 'package:hitechpos/common/app_routes.dart';
import 'package:hitechpos/dependency/hiposbindings.dart';
import 'package:get/get.dart';
import 'package:hitechpos/dependency/network_dependency_injection.dart';
// import 'package:hitechpos/views/Registration/login_screen.dart';
// import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
// import 'package:hitechpos/views/menu/menu_screen.dart';
// import 'package:hitechpos/views/onnboarding/onboarding_screen.dart';
// import 'package:hitechpos/views/order/order_screen.dart';
import 'package:hitechpos/views/Registration/splash_screen.dart';

void main() {
  runApp(const MyApp());
  NetworkDependencyInjection.init();
}
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  GetMaterialApp(              
      title: 'HiPOS',
      debugShowCheckedModeBanner: false,
      initialBinding: HiposBinding(),
      initialRoute: AppRoutes.home,
      // getPages: [
      //   GetPage(name: AppRoutes.home, page: () => const OnBoardingScreen()),
      //   GetPage(name: AppRoutes.login, page: () => LoginScreen()),
      //   //GetPage(name: AppRoutes.registration, page: () => const RegistrationScreen()),
      //   GetPage(name: AppRoutes.dashboard, page: () => const DashboardScreen()),
      //   GetPage(name: AppRoutes.menu, page: () => MenuScreen()),
      //   GetPage(name: AppRoutes.order, page: () => const OrderScreen())
      // ],
      home: const SafeArea(
        child: SplashScreen(title: "HiPOS"),
      ),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
    
  }
  
}
