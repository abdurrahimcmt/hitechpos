import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/screens/Registration/login_screen.dart';

class CommonDialogBoxes {

    AlertDialog alartDialogYesNoOption(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Get.offAll(const LoginScreen());
          },
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "No",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}