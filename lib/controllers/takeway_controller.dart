import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:http/http.dart' as http;


class TakeAwayController extends GetxController{
  final loginController = Get.find<LoginController>();
  final isDataLoading = true.obs;
  late Future<CustomerInfo> customerInfo;
  late  List<CustomerList> customerList;
  late TextEditingController customerTextController = TextEditingController();

  late CustomerList selectedCustomer; 
  // CustomerList selectedCustomer = CustomerList(vBranchId: "", vCustomerId: "", vCustomerCode: "", 
  // vCustomerName: "", vVatRegNo: "", vMobileNo: "", vEmailId: "", iCreditLimit: 0, 
  // iActive: 0, vCreatedBy: "", dCreatedDate: DateTime.now(), vModifiedBy: "", 
  // dModifiedDate: DateTime.now());

  @override
  void onInit(){
    super.onInit();
    setCustomerList();
  }
  
  @override
  void onReady(){
    super.onReady();
    setCustomerList();
  }

  void setCustomerList(){
    fatchCustomerInfo().then((value) => {
      customerList = value.customerList,
    });
  }

  void setSelectedCustomer(CustomerList customer){
    selectedCustomer = customer;
  }

  CustomerList getSelectedCustomer(){
    return selectedCustomer;
  }

  Future<CustomerInfo> fatchCustomerInfo() async {
    String baseurl = loginController.baseurlFromLocalStorage;
    // https://hiposbh.com:84/api/waiterapp/customer
    final url = Uri.parse("${baseurl}api/waiterapp/customer");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        return CustomerInfo.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Customer');
    }
  }
}