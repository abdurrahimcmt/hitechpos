import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/commondialogbox.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/screens/menu/menu_screen.dart';
import 'package:hitechpos/screens/order/orderlist.dart';
import 'package:hitechpos/screens/profile/profile_page.dart';
import 'package:hitechpos/screens/settings/settings_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';
import 'package:hitechpos/widgets/dashboardbutton.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginController = Get.find<LoginController>();
    return WillPopScope(
      onWillPop: () async{
          //Clear Text data
          if(!loginController.isRememberMe.value){
            loginController.refreshTextField();
          }

          showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonDialogBoxes().alartDialogYesNoOption(
                "Confirmation",
                "Do you want to logout? ",
                context);
          },
        );
        return true;
      },
      child: Scaffold(
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
                        "Do you want to log out?",
                        context);
                  },
                );
              });
            },
            child: Icon(Icons.logout),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: const BoxDecoration(
              gradient: Palette.bgGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ProfilePage());
                          },
                          child: const DashBoardButton(title: "Profile", buttonIcon: Icons.account_circle),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const OrderListScreen());
                          },
                          child: const DashBoardButton(title: "Order List", buttonIcon: Icons.list),
                        ),
                        
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const SettingScreen());
                          },
                          child: const DashBoardButton(title: "Settings", buttonIcon: Icons.settings
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      const Expanded(
                        flex: 6,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
      ),
    );
  }
}