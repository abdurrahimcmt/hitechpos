import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/categoryInfo.dart';
import 'package:hitechpos/models/iteminfo.dart';
import 'package:http/http.dart' as http;

class MenuScreenController extends GetxController{
  final loginController = Get.find<LoginController>();
  TextEditingController searchTextEditingController = TextEditingController();
  final selectedOrderType = 0.obs;
  late Future<CategoryInfo> categoryInfoList;
  var itemInfo = ItemInfo(messageId: "", message: "", itemList: []).obs;
  var itemInfoIsloading = true.obs;
  List<String> isSelectedTabels = <String>[].obs;
  final selectedCategoryName = "".obs;
  
 @override
  void onInit() {
    super.onInit();
    
    fatchItemInfo("all","all");
    categoryInfoList = fatchCategoryInfo();
  }
  

  Future<CategoryInfo> fatchCategoryInfo() async {
    //when Auto login is true then we need to create baseUrl 
    await loginController.setBaseUrl();
    String baseurl = loginController.baseurlFromLocalStorage;
    String branch = loginController.branchIdFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/category/$branch");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        return CategoryInfo.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Category');
    }
  }
  Future<void> fatchItemInfo(String catId,String searchText) async {
    await loginController.setBaseUrl();
    itemInfoIsloading.value = true;
    String baseurl = loginController.baseurlFromLocalStorage;
    String branchId = loginController.branchIdFromLocalStorage;
    debugPrint(branchId);
    //https://hiposbh.com:84/api/waiterapp/itemlist/all/no/B0001
    final url = Uri.parse("${baseurl}api/waiterapp/itemlist/$catId/$searchText/$branchId");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json'
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        //return ItemInfo.fromJson(jsonDecode(response.body));
        itemInfo.value = itemInfoFromJson(response.body);
    }
    else{
      itemInfoIsloading.value= false;
      throw Exception('Failed to load Item');
    }
    itemInfoIsloading.value= false;
  }

  setSelectedOrderType(int index){
    selectedOrderType.value = index;
  }



}