import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/categoryInfo.dart';
import 'package:hitechpos/models/iteminfo';
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
    fatchItemInfo("all");
    categoryInfoList = fatchCategoryInfo();
  }

  Future<CategoryInfo> fatchCategoryInfo() async {
    final loginController = Get.find<LoginController>();
    String baseurl = loginController.baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/category");
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
  Future<void> fatchItemInfo(String item) async {
    itemInfoIsloading.value = true;
    final loginController = Get.find<LoginController>();
    String baseurl = loginController.baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/item/$item/");
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