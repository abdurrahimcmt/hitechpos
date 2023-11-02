import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/commondialogbox.dart';
import 'package:hitechpos/common/customnotification.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/data/notificationdata.dart';
import 'package:hitechpos/views/Registration/registrationbeforelogin.dart';
import 'package:hitechpos/views/responsive/responsive_layout.dart';
import 'package:hitechpos/widgets/curb_button.dart';
import 'package:hitechpos/widgets/curb_buttonlight.dart';

import 'registration_key.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
 // final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  _yesAction(){
    exit(0);
  }
  _noAction(){
    Get.back();
  }
  @override
  Widget build(BuildContext context) {
    //final loginController = Get.find<LoginController>();
      Size size = MediaQuery.of(context).size;
      int flexnumber = ResponsiveLayout.isDesktop(context) ? 4 : ResponsiveLayout.isTablet(context) ? 2 : 0;
      return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CommonDialogBoxes().alartDialogYesNoOption(
                "Confirmation",
                "Do you want to close the app?",
                context,_yesAction,_noAction
              );
            },
          );
          return true;
        },
        child: Scaffold(
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
                                  height: size.height*0.90,
                                  decoration: Palette.containerCurbBoxdecoration,
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Form(
                                      key: loginFormKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text("Welcome",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 30,
                                            ),
                                          ),
                                            const Text("",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Obx(
                                            () { 
                                              if(controller.isBranchLoding.value){
                                                  return const CircularProgressIndicator();
                                              }
                                              else{
                                                return DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                    isDense: true,
                                                    hintText: "Select Branch",
                                                    prefixIcon: Icon(
                                                      Icons.store_mall_directory,
                                                      color: Color.fromARGB(106, 113, 15, 131),
                                                    ),
                                                  ),
                                                  value: controller.selectedBranchId.value,
                                                  items: controller.branchDropdownItemMenu.value,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  validator: (value) {
                                                    if(value! == "0"){
                                                      controller.loginBranchFocus.requestFocus();
                                                      return "Please select Branch";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (val) {
                                                    controller.setSelectedBranch(val!);
                                                    debugPrint(val);
                                                  }
                                                );
                                              }
                                            }
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                              focusNode: controller.userNameFocus,
                                              controller: controller.userNameController,
                                              validator: (value) {
                                                if(value!.isEmpty){
                                                  controller.userNameFocus.requestFocus();
                                                  return "Please enter user name";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                hintText: "User name",
                                                prefixIcon: Icon(
                                                  Icons.person_outline,
                                                  color: Color.fromARGB(106, 113, 15, 131),
                                                ),
                                              ),
                                            ),
                                          
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          
                                            Obx(
                                              () => TextFormField(
                                                focusNode: controller.passwordFocus,
                                                controller: controller.passwordController,
                                                validator: (value) {
                                                  if(value!.isEmpty){
                                                    controller.passwordFocus.requestFocus();
                                                    return "Please enter your password";
                                                  }
                                                  return null;
                                                },
                                                obscureText: controller.secureText.value,
                                                decoration: InputDecoration(
                                                  hintText: "Password",
                                                  prefixIcon: const Icon(
                                                    Icons.lock_outline_rounded,
                                                    color: Color.fromARGB(106, 113, 15, 131),
                                                  ),
                                                  suffixIcon: IconButton(
                                                      icon: Icon(controller.secureText.value?Icons.visibility: Icons.visibility_off),
                                                      onPressed: (){
                                                        controller.visibilityOfSecureText(!controller.secureText.value);
                                                        // setState(() {
                                                        //   secureText = !secureText;
                                                        // });
                                                      },
                                                    ),
                                                  
                                                ),
                                              ),
                                            ),
                                          
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // InkWell(
                                          //   child: const Text("Remember me",
                                          //     style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 20,
                                          //       color: Palette.textColorPurple,
                                          //       fontFamily: Palette.layoutFont,
                                          //     ),
                                          //   ),
                                          //   onTap: () {
                                              
                                          //   },
                                          // ),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxWidth: 200,
                                            ),
                                            child: Obx(
                                              () => CheckboxListTile(
                                                controlAffinity: ListTileControlAffinity.leading,
                                                value: controller.isRememberMe.value, 
                                                title: const Text("Remember me",
                                                    style: TextStyle(
                                                    fontFamily: Palette.layoutFont,
                                                    fontSize: Palette.contentTitleFontSizeL,
                                                    fontWeight: FontWeight.w700,
                                                    color: Palette.textColorPurple
                                                  ),
                                                ),
                                                onChanged:(value) {
                                                  controller.setisRememberMe (value!);
                                                  controller.handleRemember(value);
                                                  
                                                  // setState(() {
                                                  //   _isRememberMe = value!;
                                                  //   _handleRemember(value);
                                                  // });
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextButton(
                                            onPressed: (){
                                            // Navigator.push(context,
                                            // MaterialPageRoute(builder: (_) => const MenuScreen(),),);
                                              if(!controller.isRegistrationSuccessfull.value){
                                                //Get.snackbar("Error", "Please register your account",snackPosition: SnackPosition.BOTTOM);
                                                CustomNotification().notification(NotificationData.error.name, "Error", "Please register your account", "top");
                                              }
                                              if (loginFormKey.currentState!.validate()) {
                                                controller.login(controller.userNameController.text.trim(), 
                                                controller.passwordController.text.trim(), 
                                                controller.selectedBranchId.value);

                                                  // print("yes");
                                                  // Navigator.of(context).pushAndRemoveUntil(
                                                  // MaterialPageRoute(
                                                  //   builder: (context) =>
                                                  //   const DashboardScreen()),
                                                  // (Route<dynamic> route) => false);
      
                                              }
                                              //Get.to(const DashboardScreen());
                                            },
                                            
                                            child: const CurbButton(
                                                buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                                child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Expanded(flex: 2, child: SizedBox()),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Text("LOGIN",style: TextStyle(
                                                      fontFamily: Palette.layoutFont,
                                                      fontWeight: Palette.btnFontWeight,
                                                      fontSize: Palette.btnFontsize,
                                                      color: Palette.btnTextColor,
                                                    ),),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Icon(Icons.login_outlined,size: 20,color: Colors.white,)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          
                                          const SizedBox(
                                            height: 20,
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
                                          TextButton(
                                            onPressed: (){
                                              Get.to(() => const RegistrationBeforeLogin());
                                              // showModalBottomSheet(context: context,
                                              //   isScrollControlled: true,
                                              //   shape: const RoundedRectangleBorder(
                                              //     borderRadius: BorderRadius.vertical(
                                              //       top: Radius.circular(40),
                                              //     )
                                              //   ), 
                                              //   builder: (BuildContext context){
                                              //     return SingleChildScrollView(
                                              //       child: Column(
                                              //         children: [
                                              //           RegistrationKeyScreen(),
                                              //         ],
                                              //       )
                                              //       );
                                              //   }
                                              // );
                                            },
                                            child: const CurbButtonLight(
                                              buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Expanded(flex: 2, child: SizedBox()),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Text(
                                                      "REGISTRATION",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(255, 125, 95, 133),
                                                        fontFamily: Palette.layoutFont,
                                                        fontWeight: Palette.btnFontWeight,
                                                        fontSize: Palette.btnFontsize,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded( 
                                                    flex: 4,
                                                    child: Icon(Icons.app_registration_sharp,size: 20,color: Color.fromARGB(255, 125, 95, 133),)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // TextButton(
                                          //   onPressed: (){
                                          //     showDialog(
                                          //       context: context,
                                          //       builder: (BuildContext context) {
                                          //         return CommonDialogBoxes().alartDialogYesNoOption(
                                          //           "Confirmation",
                                          //           "Do you want to close the app?",
                                          //           context,_yesAction,_noAction
                                          //         );
                                          //       },
                                          //     );
                                          //   },
                                          //   child: const CurbButtonLight(
                                          //     buttonPadding: EdgeInsets.only(left: 0,right: 0),
                                          //     child: Center(
                                          //       child: Text(
                                          //         "EXIT",
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
       ),
    );
  }
}