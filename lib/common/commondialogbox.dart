import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/views/Registration/login_screen.dart';

class CommonDialogBoxes {

AlertDialog alartDialogYesNoOption(String title, String content, BuildContext context) {
  final loginController = Get.find<LoginController>();
  return AlertDialog(
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    //title: Text(title),
    title: const Icon(
        Icons.info,
        size: 40,
        color: Palette.iconBackgroundColorPurple,
      ),
    content: Text(content,
      style: const TextStyle(
        color: Palette.textColorPurple,
        fontFamily: Palette.layoutFont,
        fontWeight: FontWeight.w700
      ),
      textAlign: TextAlign.center,

    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
          // Clear login and password field when remember me false
          if(!loginController.isRememberMe.value){
            loginController.refreshTextField();
          }
              Get.offAll(const LoginScreen());
            },
            child: Container(
              height: 35,
              width: 70,
              decoration:  const BoxDecoration(
                gradient: Palette.btnGradientColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Palette.btnBoxShadowColor,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: const Center(
                child: Text("Yes",
                      style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontWeight: FontWeight.w600,
                      fontSize: Palette.containerButtonFontSize,
                      color: Palette.btnTextColor,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
              height: 35,
              width: 70,
              decoration:  const BoxDecoration(
                gradient: Palette.btnGradientColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Palette.btnBoxShadowColor,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: const Center(
                child: Text("No",
                      style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontWeight: FontWeight.w600,
                      fontSize: Palette.containerButtonFontSize,
                      color: Palette.btnTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}