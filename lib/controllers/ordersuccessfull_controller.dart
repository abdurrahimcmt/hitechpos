import 'package:get/get.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';

class OrderSuccessfullController extends GetxController{

  final cartController = Get.find<CartController>();
  final proceedController = Get.find<ProceedController>();
  final diniInController = Get.find<DiniInController>();
  final menuController = Get.find<MenuScreenController>();
  final loginController = Get.find<LoginController>();
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