import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrinterSettingController extends GetxController{

  late TextEditingController printerNameController,printerIpAddressController,printerPortController,
  macAddressController;

  late FocusNode printerNameFocus,printerIpAddressFocus,printerPortFocus,macAddressFocus;
  var selectedBranch = "Kitchen".obs;

  @override
  void onInit() {
    super.onInit();
    printerNameController = TextEditingController();
    printerIpAddressController = TextEditingController();
    printerPortController = TextEditingController();
    macAddressController = TextEditingController();

    printerNameFocus = FocusNode();
    printerIpAddressFocus = FocusNode();
    printerPortFocus = FocusNode();
    macAddressFocus = FocusNode();
  }

  void testPrinter(){

  }
}