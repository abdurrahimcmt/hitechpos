import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/commondialogbox.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/screens/menu/menu_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.bgColorPerple,
        title: const Text('DashBoard'),
        leading: InkWell(
          onTap: () {
            setState(() {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CommonDialogBoxes().alartDialogYesNoOption(
                      "Confirmation",
                      "Do you want to logout? ",
                      context);
                },
              );
            });
          },
          child: Icon(Icons.logout),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: Palette.bgGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: size.height*0.2,
                ),
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: Palette.bgGradient,
                            borderRadius: Palette.textContainerBorderRadius,
                            border: Border.all(
                              color: Palette.btnBoxShadowColor,
                              width: 2,
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_circle,size: 70,color: Palette.iconBackgroundColorPurple,),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: FittedBox(
                                  child: Text("Profile",
                                        style: TextStyle(
                                          fontFamily: Palette.layoutFont,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color:Palette.textColorPurple,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: Palette.bgGradient,
                            borderRadius: Palette.textContainerBorderRadius,
                            border: Border.all(
                              color: Palette.btnBoxShadowColor,
                              width: 2,
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.list,size: 70,color: Palette.iconBackgroundColorPurple,),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: FittedBox(
                                  child: Text("Order List",
                                        style: TextStyle(
                                          fontFamily: Palette.layoutFont,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color:Palette.textColorPurple,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const MenuScreen());
                  },
                  child: const CurbButton(
                      buttonPadding: EdgeInsets.only(left: 0,right: 0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Text("NEW ORDER",style: TextStyle(
                            fontFamily: Palette.layoutFont,
                            fontWeight: Palette.btnFontWeight,
                            fontSize: Palette.btnFontsize,
                            color: Palette.btnTextColor,
                          ),
                        ),
                        Icon(Icons.library_add,size: 20,color: Colors.white,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}