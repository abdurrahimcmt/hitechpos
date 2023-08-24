import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:http/http.dart' as http;

class CustomerAndAddressController extends GetxController{
  final loginController = Get.find<LoginController>();

  final isDataLoading = true.obs;
  late Future<CustomerInfo> customerInfo;
  late  List<CustomerList> customerList;
  late TextEditingController customerTextController = TextEditingController();
  String selectedOrderTypeName = "";
  Rx<CustomerList> selectedCustomer = CustomerList(vBranchId: "", vCustomerId: "", vCustomerCode: "", 
  vCustomerName: "", vVatRegNo: "", vMobileNo: "", vEmailId: "", iCreditLimit: 0, 
  iActive: 0, vCreatedBy: "", dCreatedDate: DateTime.now(), vModifiedBy: "", 
  dModifiedDate: DateTime.now()).obs;
  CustomerAddressList selectedCustomerAddress = CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: "");
  
  late RxList<CustomerAddressList> customerAddressList = <CustomerAddressList>[].obs;
  TextEditingController carNumberController = TextEditingController();

  Rx<TextEditingValue> selectedCustomertext = const TextEditingValue(text: "").obs;
  Rx<TextEditingValue>  selectedAddress = const TextEditingValue(text: "").obs;

  @override
  void onInit(){
    super.onInit();
    setCustomerList;
  }
  @override
  void onReady(){
    super.onReady();
    setCustomerList();
  }
  void refreshWhenSelectOrderType(int orderTypeIndex){
    debugPrint("setOrderTypeData $orderTypeIndex");
    selectedOrderTypeName = orderTypes[orderTypeIndex].name;
    if(selectedOrderTypeName == "Dine In"){
      //refreshProceedController();
    }
    else if(selectedOrderTypeName == "Take Away"){
      
    }
    else if(selectedOrderTypeName == "Delivery" || selectedOrderTypeName == "Drive Through"){
     // refreshProceedController();
      if( selectedCustomer.value.vCustomerId.isNotEmpty && selectedCustomerAddress.vArea.isEmpty){
        setCustomerAddressList(selectedCustomer.value.vCustomerId);
      }
    }
  }
  void setCustomerList(){
    fatchCustomerInfo().then((value) => {
      customerList = value.customerList,
    });
  }

  void setSelectedCustomer(CustomerList customer){
    selectedCustomer.value = customer;
  }

  CustomerList getSelectedCustomer(){
    return selectedCustomer.value;
  }

  void setSelectedCustomerAddress(CustomerAddressList address){
    selectedCustomerAddress = address;
  }

  CustomerAddressList getSelectedCustomerAddress(){
    return selectedCustomerAddress;
  }

  void setCustomerAddressList(String customer){
    fatchAddressInfo(customer).then((value) => {
      customerAddressList.clear(),
      customerAddressList.value = value.customerAddressList,
    });
  }

  String combinedCustomerAddressFields(CustomerAddressList address){
    if(address.vArea.isNotEmpty || address.vBlockNo.isNotEmpty || address.vRoadNo.isNotEmpty || address.vBuildingNo.isNotEmpty || address.vFlatNo.isNotEmpty){
      return "Area: ${address.vArea}, Block No: ${address.vBlockNo}, Road No: ${address.vRoadNo}, Building No: ${address.vBuildingNo}, Flat No: ${address.vFlatNo}";
    }
    return "";
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

  Future<CustomerInfo> fatchCustomerInfo() async {
    await loginController.setBaseUrl();
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