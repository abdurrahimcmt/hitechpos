import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/userdetailsmodel.dart';
import 'package:http/http.dart' as http;

class UserDetailsController extends GetxController{
  final loginController = Get.find<LoginController>();
  late Rx<UserInfoList> userInfoList = UserInfoList(vBranchName: "", vFullName: "", vUserImage: "", vRoleName: "", vMobileNo: "", vEmailId: "", vUserTypeName: "", dExpiryDate: "").obs;
  final userDetailsIsloading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady(){
    super.onReady();
    fatchUserDetails(loginController.userIdFromLocalStorage).then((value) {
       userInfoList.value = value.userInfoList.first;
    });
  }

  Future<UserDetailsModel> fatchUserDetails(String userId) async {

    String baseurl = loginController.baseurlFromLocalStorage;
    
    final url = Uri.parse("${baseurl}api/waiterapp/userdetails/$userId");
    debugPrint(url.toString());

    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };

    final response = await http.get(url,headers: headers);
    
    if(response.statusCode == 200){
        return UserDetailsModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load user details');
    }
    
  }
}