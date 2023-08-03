import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:http/http.dart' as http;

class DriveThroughController extends GetxController {

  final loginController = Get.find<LoginController>();
  final isDataLoading = true.obs;
  late List<CustomerList> customerList;
  late TextEditingController customerTextController = TextEditingController();

  late CustomerList selectedCustomer = CustomerList(vBranchId: "", vCustomerId: "", vCustomerCode: "", vCustomerName: "", vVatRegNo: "", vMobileNo: "", vEmailId: "", iCreditLimit: 0, iActive: 0, vCreatedBy: "", dCreatedDate: DateTime.now(), vModifiedBy: "", dModifiedDate: DateTime.now());
  CustomerAddressList selectedCustomerAddress = CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: "");

  late RxList<CustomerAddressList> customerAddressList = <CustomerAddressList>[].obs;

  TextEditingController carNumberController = TextEditingController();
 
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

  void setCustomerAddressList(String customer){
    fatchAddressInfo(customer).then((value) => {
      customerAddressList.clear(),
      customerAddressList.value = value.customerAddressList,
    });
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

  void setSelectedCustomerAddress(CustomerAddressList address){
    selectedCustomerAddress = address;
  }

  CustomerAddressList getSelectedCustomerAddress(){
    return selectedCustomerAddress;
  }

  String combinedCustomerAddressFields(CustomerAddressList address){
    return "Area: ${address.vArea}, Block No: ${address.vBlockNo}, Road No: ${address.vRoadNo}, Building No: ${address.vBuildingNo}, Flat No: ${address.vFlatNo}";
  }

  Future<CustomerAddress> fatchAddressInfo(String customer) async{
    String baseurl = loginController.baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/cusaddress/$customer");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
      return CustomerAddress.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Customer address');
    }
  }

  Future<CustomerInfo> fatchCustomerInfo() async{
    String baseurl = loginController.baseurlFromLocalStorage;
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