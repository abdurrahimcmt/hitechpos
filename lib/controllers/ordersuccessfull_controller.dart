import 'package:get/get.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/printer_setting_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/models/printersmodel.dart';
import 'package:hitechpos/reports/invoice_receipt.dart';

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
  final printerSettingController = Get.find<PrinterSettingController>();

  void printReceipt(InvoiceReportModel invoiceReportData) async {
    try {
      Printers printers = await printerSettingController.getPrinterData();
      List<PrinterList> printerList = printers.printerList;
      int  index = printerList.indexWhere((PrinterList) => PrinterList.isDefault == 1);
      List<int> pdfContent = await InvoiceReceipt().makeReceipt(invoiceReportData);
      String printerIp = printerList[index].vPrinterIp;
      int printerPort = int.parse(printerList[index].vPort);
      //printViaWiFi(printerIp, printerPort, pdfContent);
      printerSettingController.printProcess(printerIp, printerPort, "80mm", pdfContent);
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