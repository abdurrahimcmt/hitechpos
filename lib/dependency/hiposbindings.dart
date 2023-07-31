import 'package:get/get.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/delivery_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/order_controller.dart';
import 'package:hitechpos/controllers/takeway_controller.dart';

class HiposBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => MenuScreenController());
    Get.lazyPut(() => DiniInController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => TakeAwayController());
    Get.lazyPut(() => DeliveryController());
  }
}