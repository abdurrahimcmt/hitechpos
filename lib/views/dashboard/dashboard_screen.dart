import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/commondialogbox.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/ordersuccessfull_controller.dart';
import 'package:hitechpos/views/Registration/login_screen.dart';
import 'package:hitechpos/views/menu/menu_screen.dart';
import 'package:hitechpos/views/order/orderlist.dart';
import 'package:hitechpos/views/profile/profile_page.dart';
import 'package:hitechpos/views/settings/settings_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';
import 'package:hitechpos/widgets/dashboardbutton.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final orderSuccessFullController = Get.find<OrderSuccessfullController>();

  _yesAction(){
    Get.to(() => LoginScreen());
  }

  _noAction(){
    Get.back();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   // final loginController = Get.find<LoginController>();
    
    return WillPopScope(
      onWillPop: () async{
          //Clear Text data
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CommonDialogBoxes().alartDialogYesNoOption(
              "Confirmation",
              "Do you want to logout? ",
              context,_yesAction,_noAction
            );
          },
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Palette.bgColorPerple,
          title: const Text('Dashboard'),
          leading: InkWell(
            onTap: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CommonDialogBoxes().alartDialogYesNoOption(
                        "Confirmation",
                        "Do you want to log out?",
                        context,_yesAction,_noAction
                    );
                  },
                );
              });
            },
            child: const Icon(Icons.logout),
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
                            Get.to(() => const ProfilePage());
                          },
                          child: const DashBoardButton(title: "Profile", buttonIcon: Icons.account_circle),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const OrderListScreen());
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
                            Get.to(() => const SettingScreen());
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
                      orderSuccessFullController.clearCartData();
                      Get.to(() => MenuScreen());
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