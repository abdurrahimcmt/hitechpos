import 'package:flutter/material.dart';

import 'package:hitechpos/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // Color _primaryColor = HexColor('#DC54FE');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 44, 30, 243),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: const Color.fromARGB(255, 7, 73, 255)),
      ),
      home: const SafeArea(
        child: SplashScreen(title: 'Food Delivery'),
      ),
    );
  }
}
