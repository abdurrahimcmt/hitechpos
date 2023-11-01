import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:hitechpos/models/printersmodel.dart';
import 'package:hitechpos/reports/printingservices.dart';
import 'package:hitechpos/views/settings/printermanagment_screen.dart';
import 'package:hitechpos/views/settings/printersetting_screen.dart';
import 'package:hitechpos/widgets/loading_prograss_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrinterSettingController extends GetxController{

  late TextEditingController printerNameController,printerIpAddressController,printerPortController,
  macAddressController;

  late FocusNode printerNameFocus,printerIpAddressFocus,printerPortFocus,macAddressFocus;
  var printerLocation = "Kitchen".obs;
  var selectedPaperSize = "80mm".obs;
  var printerTest = true.obs;
  late String selectedOption;
  var printerId = "";
  bool edit = false;

  @override
  void onInit() {
    super.onInit();
    selectedOption = "len";
    printerNameController = TextEditingController();
    printerIpAddressController = TextEditingController();
    printerPortController = TextEditingController();
    macAddressController = TextEditingController();

    printerNameFocus = FocusNode();
    printerIpAddressFocus = FocusNode();
    printerPortFocus = FocusNode();
    macAddressFocus = FocusNode();
  }

  void refreshPrinterSettingController(){
    selectedOption = "len";
    printerLocation.value = "Kitchen";
    selectedPaperSize.value = "80mm";
    printerNameController.text = "";
    printerIpAddressController.text = "";
    printerPortController.text = "";
    macAddressController.text = "";
    edit = false;
  }

  Future<void> printProcess(String printerIp, int printerPort, String paperSize, List<int> pdfContent) async {
    try {
      print("printer Ip :" + printerIp);
      print("printer port :" + printerPort.toString());
      print(pdfContent);
      await printViaWiFi(printerIp, printerPort, pdfContent);
    } catch (e) {
      print('Error printing: $e');
    }
  }
  
  Future<Printers> getPrinterData() async{
    Printers printers = new Printers(totalPrinters: "", printerList: []);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(prefs.getString('printers') != null){
    //   prefs.remove('printers');
    // }
    if (prefs.getString('printers') != null) {
      String? storedPrinterData = await prefs.getString('printers');
        if (storedPrinterData != null) {
          try {
            Map<String, dynamic> printerDataMap = await jsonDecode(storedPrinterData);
            printers = await Printers.fromJson(printerDataMap);
          } catch (e) {
            debugPrint('Error parsing JSON data: $e');
          }
        }
    }
    return printers; 
  }

  Future<void> setPrintersData(Printers printers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Map<String, dynamic> printerData = await printers.toJson();
      final printerDataEncode = await jsonEncode(printerData);
      prefs.setString('printers', printerDataEncode);
    } catch (e) {
      debugPrint('Error save data: $e');
    }
  }
  
  void setEditPrinterData(PrinterList printerData) async{
    try {
      Printers printers = await getPrinterData();
      List<PrinterList> printerList = printers.printerList;
      int editIndex = printerList.indexWhere((PrinterList) => PrinterList.vPrinterId == printerData.vPrinterId);
      PrinterList editedPrinter =  printerList[editIndex];
      refreshPrinterSettingController();
      printerId = editedPrinter.vPrinterId;
      selectedOption = editedPrinter.vPrinterType;
      printerLocation.value = editedPrinter.vPrinterLocation;
      printerNameController.text = editedPrinter.vPrinterName;
      selectedPaperSize.value = editedPrinter.vPaperSize;
      printerIpAddressController.text = editedPrinter.vPrinterIp;
      printerPortController.text = editedPrinter.vPort;
      macAddressController.text = editedPrinter.vMacAddress;
      edit = true;
      Get.to(() => const PrinterSettingScreen());
    } catch (e) {
      debugPrint("SetEditPrinterData : " + e.toString());
    }
  }
  
  void deletePrinterData(PrinterList deletePrinterData) async{
    try {
      Printers printers = await getPrinterData();
      List<PrinterList> printerList = printers.printerList;
      int deleteIndex = printerList.indexWhere((PrinterList) => PrinterList.vPrinterId == deletePrinterData.vPrinterId);
      printerList.removeAt(deleteIndex);
      await setPrintersData(printers);
      Get.snackbar("Information", "Delete successful", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "delete failed", snackPosition: SnackPosition.BOTTOM);
      debugPrint("deletePrinterData : " + e.toString());
    }
  }

  void updatePrinterDat(String editPrinterId) async{
    try {
      bool duplicate = false;
      Printers printers = await getPrinterData();
      List<PrinterList> printerList = printers.printerList;
      int editIndex = printerList.indexWhere((PrinterList) => PrinterList.vPrinterId == editPrinterId);
      if(printerList[editIndex].vPrinterName != printerNameController.text){
        if(await updateIsNotDuplicate(printerNameController.text, editPrinterId)){
          duplicate = false;
        }
        else{
          duplicate = true;
          Get.snackbar("Error", "This printer name already exists", snackPosition: SnackPosition.BOTTOM);
        }
      }
      if(!duplicate){
          printerList[editIndex].vPrinterId = editPrinterId;
          printerList[editIndex].vPrinterType = selectedOption;
          printerList[editIndex].vPrinterLocation = printerLocation.value;
          printerList[editIndex].vPaperSize = selectedPaperSize.value;
          printerList[editIndex].vPrinterName = printerNameController.text;
          printerList[editIndex].vPrinterIp = printerIpAddressController.text;
          printerList[editIndex].vPort = printerPortController.text;
          printerList[editIndex].vMacAddress = macAddressController.text;
          await setPrintersData(printers);
          edit = false;
          Get.snackbar("Information", "Update successful", snackPosition: SnackPosition.BOTTOM);
          Get.to(() => const PrinterManagemntScreen());
      }
    } catch (e) {
      Get.snackbar("Error", "Update failed", snackPosition: SnackPosition.BOTTOM);
      debugPrint("updatePrinterDat : " + e.toString());
    }
  }
  
  Future<bool> updateIsNotDuplicate(String printerName , String printerId) async{
    bool isDuplicate = true;
    try {
      Printers printers = await getPrinterData();
      List<PrinterList> printerList = printers.printerList;
      printerList.forEach((element) {
        if(element.vPrinterName.isNotEmpty && element.vPrinterId != printerId){
          if(element.vPrinterName == printerName){
              isDuplicate = false;
          }
        }
      },);
    } catch (e) {
      debugPrint("isDuplicate : " + e.toString());
    }
    return isDuplicate;
  }

  Future<bool> isNotDuplicate(String printerName) async{
    bool isDuplicate = true;
    try {
      Printers printers = await getPrinterData();
      List<PrinterList> printerList = printers.printerList;
      printerList.forEach((element) {
        if(element.vPrinterName.isNotEmpty){
          if(element.vPrinterName == printerName){
              isDuplicate = false;
          }
        }
      },);
    } catch (e) {
      debugPrint("isDuplicate : " + e.toString());
    }
    return isDuplicate;
  }

  void savePrinterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool saveSuccess;
    String printerType = "";
    String printerName = printerNameController.text;
    String printerIp = printerIpAddressController.text.toString().trim().isNotEmpty
        ? printerIpAddressController.text.toString().trim()
        : "";
    String printerPort = printerPortController.text.toString().trim().isNotEmpty
        ? printerPortController.text.toString().trim()
        : "";
    String macAddress = macAddressController.text.toString().trim().isNotEmpty
        ? macAddressController.text.toString().trim()
        : "";
    String paperSize = selectedPaperSize.value;

    if(await isNotDuplicate(printerName))
    {
      try {
        if (selectedOption == "len") {
          printerType = "len";
        } else {
          printerType = "Bluetooth";
        }
        Printers printers = await getPrinterData();

        if (printers.printerList.isNotEmpty) {
          printers.totalPrinters = (int.parse(printers.totalPrinters) + 1).toString();
          List<PrinterList> printerList = printers.printerList;

          PrinterList printer = new PrinterList(
            vPrinterType: printerType,
            vPrinterLocation: printerLocation.value,
            vPrinterId: printers.totalPrinters,
            vPrinterName: printerName,
            vPaperSize: paperSize,
            vPrinterIp: printerIp,
            vPort: printerPort,
            vMacAddress: macAddress,
          );

          printerList.add(printer);
          printers = Printers(totalPrinters: printers.totalPrinters, printerList: printerList);
          await setPrintersData(printers);

        } else {
          List<PrinterList> printerList = [];
          PrinterList printer = new PrinterList(
            vPrinterType: printerType,
            vPrinterLocation: printerLocation.value,
            vPrinterId: "1",
            vPrinterName: printerName,
            vPaperSize: paperSize,
            vPrinterIp: printerIp,
            vPort: printerPort,
            vMacAddress: macAddress,
          );

          printerList.add(printer);
          Printers printers = Printers(totalPrinters: '1', printerList: printerList);
          await setPrintersData(printers);
        }

        // Read Data
        
        String? getPrefs = await prefs.getString('printers');
        debugPrint('SAVE TO LOCAL $getPrefs');
        saveSuccess = true;
      } catch (e) {
        debugPrint(e.toString());
        saveSuccess = false;
      }
      if (saveSuccess) {
        Get.snackbar("Information", "Save successful", snackPosition: SnackPosition.BOTTOM);
        Get.to(() => const PrinterManagemntScreen());
      } else {
        Get.snackbar("Error", "Failed to save data", snackPosition: SnackPosition.BOTTOM);
      }
    }
    else{
      Get.snackbar("Error", "This printer name already exists", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void testBluetoothPrinter(){

  }
  
  void testWifiPrinter() async{
    try {
      Get.to(() => const LoadingPrograssScreen());
      String printerIp = printerIpAddressController.text.toString().trim();
      String printerPort = printerPortController.text.toString().trim();
      String paperSize = printerIpAddressController.text;
      List<int> pdfContent = await testReceiptGenerator();
      await printProcess(printerIp, int.parse(printerPort), paperSize, pdfContent);
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<int>> testReceiptGenerator() async {
    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      List<int> bytes = [];
      bytes += generator.text('Print Test Successfully',
        styles: const PosStyles(
          align: PosAlign.center,
          underline: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),linesAfter: 1);
      bytes += generator.feed(2);
      bytes += generator.cut();
      return bytes;
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      rethrow;
    }
  }
}