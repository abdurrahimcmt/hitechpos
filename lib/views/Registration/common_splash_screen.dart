import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/views/Registration/login_screen.dart';
import 'package:hitechpos/views/Registration/registrationbeforelogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonSplashScreen extends StatefulWidget {
  const CommonSplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CommonSplashScreenState createState() => _CommonSplashScreenState();
}

class _CommonSplashScreenState extends State<CommonSplashScreen> {
 // ignore: unused_field
 bool _isVisible = false;

  _CommonSplashScreenState() {
    var isRegistrationSuccessfull = false;
    void checkRegistration() async{
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        isRegistrationSuccessfull = prefs.getBool(SharedPreferencesKeys.isregistration.name) ?? false;
        debugPrint("Is Registration $isRegistrationSuccessfull");
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    checkRegistration();
    debugPrint("auto login $isRegistrationSuccessfull");
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => isRegistrationSuccessfull ? LoginScreen() : const RegistrationBeforeLogin()),
            (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: Palette.onBoardingBoxGradient,
      ),
      child: const Center(
          child: CircularProgressIndicator()
        ),
      // child: AnimatedOpacity(
      //   opacity: _isVisible ? 1.0 : 0,
      //   duration: const Duration(milliseconds: 1200),
      //   child: Center(
      //     child: Container(
      //       height: 160.0,
      //       width: 160.0,
      //       decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.3),
      //               blurRadius: 2.0,
      //               offset: const Offset(5.0, 3.0),
      //               spreadRadius: 2.0,
      //             )
      //           ]),
      //       child: const Center(
      //         child: ClipOval(
      //           // child: Icon(
      //           //   Icons.android_outlined,
      //           //   size: 128,
      //           // ), //put your logo here
      //           child: Image(
      //             image: AssetImage('assets/images/img-01.png'),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
