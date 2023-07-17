import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';

class HiposBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}