import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/screens/responsive/responsive_layout.dart';
import 'package:hitechpos/screens/Menu/menu_screen.dart';
import 'package:hitechpos/screens/Registration/login_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';
import 'package:hitechpos/widgets/curb_buttonLight.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool secureText = false;
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
                        decoration: BoxDecoration(
                          gradient: Palette.bgGradient,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Hi-Tech",
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
                              children: <Widget>[
                                Container(
                                  height: 700,
                                  decoration: Palette.containerCurbBoxdecoration,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Create your account",
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
                                          height: 20,
                                        ),
                                        const TextField(
                                          decoration: InputDecoration(
                                            hintText: "Create an account here",
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                              color: Color.fromARGB(106, 113, 15, 131),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const TextField(
                                          decoration: InputDecoration(
                                            hintText: "Email Address",
                                            prefixIcon: Icon(Icons.mail_outline,
                                            color: Color.fromARGB(106, 113, 15, 131),),
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
                                              Icons.lock_outline_rounded,color: Color.fromARGB(106, 113, 15, 131),
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
                                          Navigator.push(context, 
                                          MaterialPageRoute(builder: (_) => const MenuScreen(),),);}, 
                                            child: const CurbButton(
                                              buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                              child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("REGISTER",style: TextStyle(
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
                                        const Center(
                                          child: Text("Already have and account?",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextButton(
                                          onPressed: (){ 
                                          Navigator.push(context, 
                                          MaterialPageRoute(builder: (_) => const LoginScreen(),),);}, 
                                          child: const CurbButtonLight(
                                            buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                            child: Text(
                                              "SIGN IN",
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 125, 95, 133),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
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