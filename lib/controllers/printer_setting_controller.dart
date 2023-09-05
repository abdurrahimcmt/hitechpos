import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:printing/printing.dart';


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

  void refreshPrinterSettingController(){
    printerNameController.text = "";
    printerIpAddressController.text = "";
    printerPortController.text = "";
    macAddressController.text = "";
  }

  void testWifiPrinter(){

  }
  void testBluetoothPrinter(){

  }

  Future<pw.Document> generatePdfDocument() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello, World!', style: pw.TextStyle(fontSize: 20)),
          );
        },
      ),
    );
    return pdf;
  }

Future<void> printPdf(pw.Document pdf) async {
  //final PrintingInfo info = await Printing.info();

  // if (info.directPrint) {
  //   await Printing.directPrintPdf(pdf: pdf);
  // } else {
  //   await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  // }
}

}