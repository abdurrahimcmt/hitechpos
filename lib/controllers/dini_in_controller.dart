import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/floorandtableinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiniInController extends GetxController{
  //selected table should comes from database
  List<String> isSelectedTabels = selectedTables;
  final newSelectedTable = "".obs;
  final isTableInfoLoding = true.obs;
  int selectcount = 0;
  late Future<FloorAndTableInfo> floorInfoList;
  var tableList = FloorAndTableInfo(message: '', messageId: '', onlineFloorTableList: []).obs;
  @override
  void onInit() {
    super.onInit();
    
    fatchTableInfo("all");
    floorInfoList = fatchFloorAndTableInfo();
  }

  Future<void> fatchTableInfo(String floor) async {
    isTableInfoLoding.value = true;
    final loginController = Get.find<LoginController>();
    String baseurl = loginController.baseurlFromLocalStorage;
    String branchId = loginController.branchIdFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/table/$floor/$branchId");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json'
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        tableList.value = floorAndTableInfoFromJson(response.body);
    }
    else{
      isTableInfoLoding.value= false;
      throw Exception('Failed to load Table');
    }
    isTableInfoLoding.value= false;
  }

Future<FloorAndTableInfo> fatchFloorAndTableInfo() async {
    final loginController = Get.find<LoginController>();
    String baseurl = loginController.baseurlFromLocalStorage;
    String branchId = loginController.branchIdFromLocalStorage;
    // https://hiposbh.com:84/api/waiterapp/table/all/B0001
    final url = Uri.parse("${baseurl}api/waiterapp/table/all/$branchId");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        return FloorAndTableInfo.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Floor and Table');
    }
  }
}