import 'package:flutter/material.dart';
import 'package:hitechpos/dependency/hiposbindings.dart';
import 'package:get/get.dart';
import 'package:hitechpos/views/onnboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'HIPOS',
      debugShowCheckedModeBanner: false,
      initialBinding: HiposBinding(),
      // initialRoute: AppRoutes.home,
      // getPages: [
      //   GetPage(name: AppRoutes.home, page: () => const OnBoardingScreen()),
      //   GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
      //   GetPage(name: AppRoutes.registration, page: () => const RegistrationScreen()),
      //   GetPage(name: AppRoutes.menu, page: () => MenuScreen()),
      //   //GetPage(name: AppRoutes.order, page: () => const OrderScreen(food: nul,))
      // ],
      home: const SafeArea(
      child: OnBoardingScreen(),
      // child: LoginScreen(),
      ),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
