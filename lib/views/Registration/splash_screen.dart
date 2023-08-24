import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import 'package:hitechpos/views/onnboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    var autoLogin = false;

    void loadedScreen() async{
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        autoLogin = prefs.getBool(SharedPreferencesKeys.autoLogin.name) ?? false;
        debugPrint("auto login $autoLogin");
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    loadedScreen();

    debugPrint("auto login $autoLogin");


    Timer(const Duration(milliseconds: 2000), () {
      setState(() {

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => autoLogin ? const DashboardScreen() : const OnBoardingScreen()),
            (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: Palette.onBoardingBoxGradient,
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 160.0,
            width: 160.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: const Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]),
            child: const Center(
              child: ClipOval(
                // child: Icon(
                //   Icons.android_outlined,
                //   size: 128,
                // ), //put your logo here
                child: Image(
                  image: AssetImage('assets/images/img-01.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
