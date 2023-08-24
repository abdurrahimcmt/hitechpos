import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/widgets/loading_prograss_screen.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isSnackbarOpen = false.obs;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    showErrorAndLoadingScreen(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    showErrorAndLoadingScreen(connectivityResult);
  }
  
  void showErrorAndLoadingScreen(ConnectivityResult connectivityResult){
      if (connectivityResult == ConnectivityResult.none) {
      isSnackbarOpen.value = true;
      Get.to(() => const LoadingPrograssScreen(), binding: LoadingProgressScreenBinding());

      Get.snackbar(
        "Error", "Please check your internet connection",
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red[400],
        icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (isSnackbarOpen.value) {
        isSnackbarOpen.value = false;
        if(Get.isSnackbarOpen){
          Get.closeCurrentSnackbar();
        }
        Get.back();
        Get.close(1);
      }
    }
  }
}

class LoadingProgressScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadingPrograssScreen());
  }
}
