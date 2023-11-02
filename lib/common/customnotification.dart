import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/data/notificationdata.dart';



class CustomNotification {
  double topMargin = 50.00;
  double bottomMargin = 100.00;
  double leftMargin = 20.00;
  double rightMargin = 20.00;
  void notification(String type,String title, String message, String position){

    if(type == NotificationData.success.name){
      Get.snackbar(
        title, 
        message, 
        snackPosition: position == "bottom" ?  SnackPosition.BOTTOM : SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green[900] ,
        margin: position == "bottom" ?  EdgeInsets.only(bottom: bottomMargin, left: leftMargin, right: rightMargin) :
         EdgeInsets.only(top: topMargin, left: leftMargin, right: rightMargin),
        padding: EdgeInsets.all(20),
        icon: Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 40,
        ),
        isDismissible: true,
      );
    }

    if(type == NotificationData.info.name){
      Get.snackbar(
        title, 
        message, 
        snackPosition: position == "bottom" ?  SnackPosition.BOTTOM : SnackPosition.TOP,
        colorText: Colors.black,
        backgroundColor: Colors.blue[400],
        margin: position == "bottom" ?  EdgeInsets.only(bottom: bottomMargin, left: leftMargin, right: rightMargin) :
         EdgeInsets.only(top: topMargin, left: leftMargin, right: rightMargin),
        padding: EdgeInsets.all(20),
        icon: Icon(
          Icons.info_rounded,
          color: Colors.black,
          size: 40,
        ),
        isDismissible: true,
      );
    }

    if(type == NotificationData.warning.name){
      Get.snackbar(
        title, 
        message, 
        snackPosition: position == "bottom" ?  SnackPosition.BOTTOM : SnackPosition.TOP,
        colorText: Colors.black,
        backgroundColor: Colors.amber[700],
        margin: position == "bottom" ?  EdgeInsets.only(bottom: bottomMargin, left: leftMargin, right: rightMargin) :
         EdgeInsets.only(top: topMargin, left: leftMargin, right: rightMargin),
        padding: EdgeInsets.all(20),
        icon: Icon(
          Icons.warning_rounded,
          color: Colors.black,
          size: 40,
        ),
        isDismissible: true,
      );
    }

    if(type == NotificationData.delete.name){
      Get.snackbar(
        title, 
        message, 
        snackPosition: position == "bottom" ?  SnackPosition.BOTTOM : SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.cyan[900],
        margin: position == "bottom" ?  EdgeInsets.only(bottom: bottomMargin, left: leftMargin, right: rightMargin) :
         EdgeInsets.only(top: topMargin, left: leftMargin, right: rightMargin),
        padding: EdgeInsets.all(20),
        icon: Icon(
          Icons.delete_rounded,
          color: Colors.white,
          size: 40,
        ),
        isDismissible: true,
      );
    }

    if(type == NotificationData.error.name){
      Get.snackbar(
        title, 
        message, 
        snackPosition: position == "bottom" ?  SnackPosition.BOTTOM : SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red[900],
        margin: position == "bottom" ?  EdgeInsets.only(bottom: bottomMargin, left: leftMargin, right: rightMargin) :
         EdgeInsets.only(top: topMargin, left: leftMargin, right: rightMargin),
        padding: EdgeInsets.all(20),
        icon: Icon(
          Icons.report_gmailerrorred_rounded,
          color: Colors.white,
          size: 40,
        ),
        isDismissible: true,
      );
    }
    /*
    Get.snackbar(
      title, 
      message, 
      snackPosition: position == "bottom" ?  SnackPosition.BOTTOM : SnackPosition.TOP,
      colorText: Colors.white,

      backgroundColor: type == NotificationData.success.name ? Colors.green[900] : 
      type == NotificationData.warning.name ? Colors.amber[700] : 
      type == NotificationData.info.name ? Colors.blue[400] :
      type == NotificationData.error.name ? Colors.red[900] :
      type == NotificationData.delete.name ? Colors.cyan[900] : Colors.white,

      margin: EdgeInsets.only(bottom: 100, left: 20, right: 20),
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 40,
      ),
      isDismissible: true,
    );
    */
  }
}

