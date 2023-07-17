import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/screens/menu/menu_screen.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key});
    
  @override
  Widget build(BuildContext context) {
    _commonTextStyle(double fSize){
      return TextStyle(
        fontFamily: Palette.layoutFont,
        fontWeight: FontWeight.w600,
        fontSize: fSize,
        color: Colors.white,
      );
    }
    Size size = MediaQuery.of(context).size;
    bool ispotrait= MediaQuery.of(context).orientation == Orientation.portrait;
    double sizeboxheight = ispotrait? 10.0 : 5.0;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: Palette.bgGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height*0.1,
              ),
              Image(image: AssetImage('assets/images/img-01.png'),
                height: ispotrait ? 100 : 80,
              ),
              Container(
                height: size.height*0.5,
                width: size.width*0.9,
                decoration: const BoxDecoration(
                  gradient: Palette.btnGradientColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle,color: Colors.white,size: ispotrait ? 80: 50,),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Text("Order Successfully Done",
                      style: _commonTextStyle(20),
                    ),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Text("Total Amount: BHD 154.000 ",
                      style: _commonTextStyle(15),
                    ),
                    SizedBox(
                      height: sizeboxheight+20,
                    ),
                    Text("Order Number",
                      style: _commonTextStyle(18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("58440",
                      style: _commonTextStyle(60),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: ispotrait ? size.height*0.1 : 5,
              ),
              TextButton(onPressed: (){
                  Get.off(MenuScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: 50,
                  decoration:  const BoxDecoration(
                    gradient: Palette.btnGradientColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.btnBoxShadowColor,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text("CONTINUE",
                          style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontWeight: Palette.btnFontWeight,
                          fontSize: Palette.btnFontsize,
                          color: Palette.btnTextColor,
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}