import 'package:get/get.dart';
import 'package:hitechpos/controllers/network_controller.dart';

class NetworkDependencyInjection {
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}