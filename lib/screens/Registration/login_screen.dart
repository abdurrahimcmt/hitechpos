import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/screens/dashboard/dashboard_screen.dart';
import 'package:hitechpos/screens/responsive/responsive_layout.dart';
import 'package:hitechpos/widgets/curb_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool secureText = true;
  @override
  void initState(){
    super.initState();
    secureText = true;
  }
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      int flexnumber = ResponsiveLayout.isDesktop(context) ? 4 : ResponsiveLayout.isTablet(context) ? 2 : 0;
      return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
          image: const AssetImage("assets/images/restaurant0.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.8),
              BlendMode.darken
            ),
          ),
        ),   
        child: Row(
          children: [
              Expanded(
                flex: flexnumber,
                child: const SizedBox(
                ),
              ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: Palette.bgGradient,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            // const Text("HIPOS",
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w900,
                            //     fontSize: 40
                            //   ),
                            // ),
                            const Image(image: AssetImage('assets/images/img-01.png'),
                            height: 50,
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
                              children: <Widget>[
                                Container(
                                  height: 700,
                                  decoration: Palette.containerCurbBoxdecoration,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text("Welcome back",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                        ),
                                        const SizedBox(
                                          height: 80,
                                        ),
                                        const TextField(
                                          decoration: InputDecoration(
                                            hintText: "User name or gmail",
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                              color: Color.fromARGB(106, 113, 15, 131),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          obscureText: secureText,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            prefixIcon: const Icon(
                                              Icons.lock_outline_rounded,
                                              color: Color.fromARGB(106, 113, 15, 131),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(secureText?Icons.visibility: Icons.visibility_off),
                                              onPressed: (){
                                                setState(() {
                                                  secureText = !secureText;
                                                });
                                              },
                                            )
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        TextButton(
                                          onPressed: (){
                                          // Navigator.push(context,
                                          // MaterialPageRoute(builder: (_) => const MenuScreen(),),);
                                          Get.to(const DashboardScreen());}, 
                                            child: const CurbButton(
                                              buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                              child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("LOGIN",style: TextStyle(
                                                  fontFamily: Palette.layoutFont,
                                                  fontWeight: Palette.btnFontWeight,
                                                  fontSize: Palette.btnFontsize,
                                                  color: Palette.btnTextColor,
                                                ),),
                                                Icon(Icons.arrow_forward,size: 20,color: Colors.white,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        // Center(
                                        //   child: Column(
                                        //     children: [
                                        //       InkWell(
                                        //         child: const Text("Forgot Password?",
                                        //           style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 20,
                                        //             color: Palette.textColorPurple,
                                        //             fontFamily: Palette.layoutFont,
                                        //           ),
                                        //         ),
                                        //         onTap: () {
                                        //           Navigator.push(context,
                                        //            MaterialPageRoute(builder: (_) => const ForgotPasswordPage(),),);
                                        //         },
                                        //       ),
                                        //       const SizedBox(
                                        //         height: 20,
                                        //       ),
                                        //       const Text("Don't have an account?",
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.w400,
                                        //             fontSize: 20,
                                        //             color: Colors.grey,
                                        //             fontFamily: Palette.layoutFont,                                             
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                          
                                        // ),
                                        // const SizedBox(
                                        //   height: 30,
                                        // ),
                                        // TextButton(
                                        //   onPressed: (){ 
                                        //   Navigator.push(context, 
                                        //   MaterialPageRoute(builder: (_) => const RegistrationScreen(),),);}, 
                                        //   child: const CurbButtonLight(
                                        //     buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                        //     child: Center(
                                        //       child: Text(
                                        //         "CREATE AN ACCOUNT",
                                        //         style: TextStyle(
                                        //           color: Color.fromARGB(255, 125, 95, 133),
                                        //           fontWeight: FontWeight.w600,
                                        //           fontSize: 20,
                                        //           fontFamily: Palette.layoutFont,
                                        //         ),
                                        //         textAlign: TextAlign.center,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
            ),
            Expanded(
              flex: flexnumber,
              child: const SizedBox(
              ),
            ),
          ],
        ),
      ),
        
      
    );
  }
}