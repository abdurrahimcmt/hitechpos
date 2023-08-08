import 'package:get/get.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';

class OrderSuccessfullController extends GetxController{
  final cartController = Get.find<CartController>();
  final proceedController = Get.find<ProceedController>();

  void clearCartData(){
    cartController.cartDetailsModelList.value.clear();
  }
}