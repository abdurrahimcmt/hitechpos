import 'package:get/get.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/reports/invoice_receipt.dart';
import 'package:hitechpos/reports/printingservices.dart';

class OrderSuccessfullController extends GetxController{

  bool isScreenOpen = false;

  @override
  void onInit() {
    super.onInit();
    isScreenOpen = true;
  }
  @override
  void onClose() {
    isScreenOpen = false;
    super.onClose();
  }

  final cartController = Get.find<CartController>();
  final proceedController = Get.find<ProceedController>();
  final diniInController = Get.find<DiniInController>();
  final menuController = Get.find<MenuScreenController>();
  final loginController = Get.find<LoginController>();

  void printReceipt(InvoiceReportModel invoiceReportData) async {
    try {
      List<int> pdfContent = await InvoiceReceipt().makeReceipt(invoiceReportData);
      //Uint8List pdfContent = await InvoiceReport().makePdf(invoice); // Your generated PDF content
      String printerIp = '192.168.2.100'; // Replace with the printer's IP address
      int printerPort = 9100; // Replace with the printer's port
      print("printer Ip :" + printerIp);
      print("printer port :" + printerPort.toString());
      print(pdfContent);
      printViaWiFi(printerIp, printerPort, pdfContent);
      proceedController.isReportPrint = false;
    } catch (e) {
      print('Error printing: $e');
    }
  }
  void clearCartData(){
    cartController.cartDetailsModelList.value.clear();
    proceedController.refreshProceedController();
    diniInController. refreshDiniInFloorAndTable();
    menuController.refreshMenuController();
    cartController.refreshCartController();
    loginController.setInvoiceId = "";
    loginController.setInvoiceNo = "";
  }
}