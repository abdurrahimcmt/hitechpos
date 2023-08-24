import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/floorandtableinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiniInController extends GetxController{
  //selected table should comes from database
  List<String> isSelectedTabels = [];

  final newSelectedTable = "".obs;
  final isTableInfoLoding = true.obs;
  //int selectcount = 0;
  Rx<OnlineFloorTableList> selectedFloor = OnlineFloorTableList(vBranchId: "", iFloorId: "", vFloorName: "", onlineTableList: []).obs;
  Rx<OnlineTableList> selectedTable = OnlineTableList(vBranchId: "", vTableId: "", vTableName: "", vInvoiceId: "", vInvoiceNo: "").obs;
  late Future<FloorAndTableInfo> floorInfoList;
  late Future<FloorAndTableInfo> tableListfuture;
  var tableList = FloorAndTableInfo(message: '', messageId: '', onlineFloorTableList: []).obs;
  @override
  void onInit() {
    super.onInit();
    isSelectedTabels.clear();
    setfloorList();
    floorInfoList.then((value) {
      selectedFloor.value = value.onlineFloorTableList.first;
    });
  }
  void setSelectedTableAndFloorfromDatabase(String? floorId,String tableId) async {
    floorInfoList.then((value) {
      selectedFloor.value = value.onlineFloorTableList.firstWhere(
          (element) => element.iFloorId == floorId,
          orElse: () => OnlineFloorTableList(vBranchId: "", iFloorId: "", vFloorName: "", onlineTableList: []),
        );
      });
      if(selectedFloor.value.onlineTableList.isNotEmpty){
        selectedTable.value = selectedFloor.value.onlineTableList.firstWhere(
          (element) => element.vTableId == tableId,
          orElse: () => OnlineTableList(vBranchId: "", vTableId: "", vTableName: "", vInvoiceId: "", vInvoiceNo: ""),
      );   
    }
  }
   
  void setfloorList(){
    floorInfoList =  fatchFloorAndTableInfo();
  }

  void refreshDiniInFloorAndTable(){
    isSelectedTabels = [];                                                                                         
    newSelectedTable.value = "";
    selectedFloor = selectedFloor;
    selectedTable.value = OnlineTableList(vBranchId: "", vTableId: "", vTableName: "", vInvoiceId: "", vInvoiceNo: "");
  }
  // @override
  // void onReady(){
  //   if(selectedFloor.value.iFloorId.isNotEmpty){
  //     fatchTableInfo(selectedFloor.value.iFloorId);
  //   }
  //   else{
  //     Timer(const Duration(seconds: 1), () {
  //       fatchTableInfo(selectedFloor.value.iFloorId);
  //     });
  //   }
  //   super.onReady();
  // }

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
      debugPrint('Failed to load Table');
    }
    isTableInfoLoding.value= false;
    //selectedTable.value = OnlineTableList(vBranchId: "", vTableId: "", vTableName: "", vInvoiceId: "", vInvoiceNo: "");
    //newSelectedTable.value = "";
    //selectcount = 0;
  }

  Future<FloorAndTableInfo> fatchFloorAndTableInfo() async {
    final loginController = Get.find<LoginController>();
    await loginController.setBaseUrl();
    String baseurl = loginController.baseurlFromLocalStorage;
    String branchId = loginController.branchIdFromLocalStorage;
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