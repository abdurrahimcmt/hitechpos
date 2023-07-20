import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';

class HiposBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => MenuScreenController());
  }
}