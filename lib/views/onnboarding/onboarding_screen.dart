import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/views/Registration/common_splash_screen.dart';
import 'package:hitechpos/views/Registration/login_screen.dart';
import 'package:hitechpos/views/Registration/registration_key.dart';
import 'package:hitechpos/views/Registration/registrationbeforelogin.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import '../../data/onboarding.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key?key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
Widget build(BuildContext context) {
  Size size= MediaQuery.of(context).size;
  return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: Palette.bgGradient,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("HIPOS",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 40
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Restaurant App",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 100, bottom: 20),
                                  height: MediaQuery.of(context).orientation == Orientation.portrait? 500 : 600,
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    gradient: Palette.onBoardingBoxGradient,
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context).orientation == Orientation.portrait? 110 : 220,
                                        ),
                                        Text(
                                          contents[i].title,
                                          style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: Palette.layoutFont
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          contents[i].discription,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: Palette.layoutFont
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: MediaQuery.of(context).orientation == Orientation.portrait? 100 : 150,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: (MediaQuery.of(context).orientation == Orientation.portrait? 100 : 150) - 5,
                                        backgroundImage: NetworkImage(contents[i].image,),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: MediaQuery.of(context).orientation == Orientation.portrait? 90 : 100,
                                  left: MediaQuery.of(context).orientation == Orientation.portrait? size.width*0.40: size.width*0.43,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        contents.length,
                                        (index) => buildDot(index, context),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: size.width*0.27,
                                    child: Center(
                                      child: TextButton(
                                        child: Container(
                                           width: size.width*0.4,
                                            height: 50,
                                            decoration:  const BoxDecoration(
                                              gradient: Palette.btnGradientColor,
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Palette.btnBoxShadowColor,
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                            ),
                                          child: Center(
                                            child: Text(  
                                                currentIndex == contents.length - 1 ? "Continue" : "Next",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (currentIndex == contents.length - 1) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => const CommonSplashScreen(title: "Hipos"),
                                              ),
                                            );
                                          }
                                          _controller.nextPage(
                                            duration: const Duration(milliseconds: 100),
                                            curve: Curves.bounceIn,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            ),                    
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
      Container buildDot(int index, BuildContext context) {
      return Container(
        height: 10,
        width: currentIndex == index ? 25 : 10,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
      );
    }
}

