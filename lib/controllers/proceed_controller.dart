import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/delivery_controller.dart';
import 'package:hitechpos/controllers/drivethrough_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/takeway_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:http/http.dart' as http;

class ProceedController extends GetxController {

  final loginController = Get.find<LoginController>();
  final menuController = Get.find<MenuScreenController>();
  final driveThroughController = Get.find<DriveThroughController>();
  final deliveryController = Get.find<DeliveryController>();
  final takeAwayController = Get.find<TakeAwayController>();
  final isDataLoading = true.obs;
  late List<CustomerList> customerList;
  late TextEditingController customerTextController = TextEditingController();

  CustomerList selectedCustomer = CustomerList(vBranchId: "", vCustomerId: "", vCustomerCode: "", vCustomerName: "", vVatRegNo: "", vMobileNo: "", vEmailId: "", iCreditLimit: 0, iActive: 0, vCreatedBy: "", dCreatedDate: DateTime.now(), vModifiedBy: "", dModifiedDate: DateTime.now());
  CustomerAddressList selectedCustomerAddress = CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: "");

  late RxList<CustomerAddressList> customerAddressList = <CustomerAddressList>[].obs;

  TextEditingController carNumberController = TextEditingController();
  String selectedOrderTypeName = "";
  Rx<TextEditingValue> selectedCustomertext = const TextEditingValue(text: "").obs;
  Rx<TextEditingValue>  selectedAddress = const TextEditingValue(text: "").obs;
 
  @override
  void onInit(){
    setOrderTypeData(menuController.selectedOrderType.value);
    selectedCustomertext.value = TextEditingValue(text: getSelectedCustomer().vCustomerName);
    selectedAddress.value = TextEditingValue(text: combinedCustomerAddressFields(getSelectedCustomerAddress()));
    setCustomerList();
    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
    setCustomerList();
  }

  

  void setOrderTypeData(int orderTypeIndex){
    debugPrint("setOrderTypeData $orderTypeIndex");
    selectedOrderTypeName = orderTypes[orderTypeIndex].name;
    if(selectedOrderTypeName == "Dine In"){
      refreshProceedController();
      debugPrint("name${selectedCustomer.vCustomerName}");
      debugPrint("Area${selectedCustomerAddress.vArea}");
    }
    else if(selectedOrderTypeName == "Take Away"){
      refreshProceedController();
      if(takeAwayController.selectedCustomer.vCustomerId.isNotEmpty){
        selectedCustomer = takeAwayController.selectedCustomer;
      }
      debugPrint("name${selectedCustomer.vCustomerName}");
      debugPrint("Area${selectedCustomerAddress.vArea}");
    }
    else if(selectedOrderTypeName == "Delivery"){
      refreshProceedController();
      if(deliveryController.selectedCustomer.vCustomerId.isNotEmpty){
        selectedCustomer = deliveryController.selectedCustomer;
      }
      if(deliveryController.selectedCustomerAddress.vArea.isNotEmpty){
        selectedCustomerAddress = deliveryController.selectedCustomerAddress;
      }
      debugPrint("name${selectedCustomer.vCustomerName}");
      debugPrint("Area${selectedCustomerAddress.vArea}");
    }
    else if(selectedOrderTypeName == "Drive Through"){
      refreshProceedController();
      if(driveThroughController.selectedCustomer.vCustomerId.isNotEmpty){
        selectedCustomer = driveThroughController.selectedCustomer;
      }
      if(driveThroughController.selectedCustomerAddress.vArea.isNotEmpty){
        selectedCustomerAddress = driveThroughController.selectedCustomerAddress;
      }
      if(driveThroughController.carNumberController.text.isNotEmpty){
        carNumberController.text = driveThroughController.carNumberController.text;
      }
      debugPrint("name${selectedCustomer.vCustomerName}");
      debugPrint("Area${selectedCustomerAddress.vArea}");

      selectedCustomertext.value = TextEditingValue(text: getSelectedCustomer().vCustomerName);
      selectedAddress.value = TextEditingValue(text: combinedCustomerAddressFields(getSelectedCustomerAddress()));
    }
  }

  void refreshProceedController(){
    selectedCustomer = CustomerList(vBranchId: "", vCustomerId: "", 
    vCustomerCode: "", vCustomerName: "", vVatRegNo: "", vMobileNo: "", vEmailId: "", 
    iCreditLimit: 0, iActive: 0, vCreatedBy: "", dCreatedDate: DateTime.now(), vModifiedBy: "", 
    dModifiedDate: DateTime.now());

    selectedCustomerAddress = CustomerAddressList(vCustomerId: "", vAddId: "",
    vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: "");

    carNumberController.text = "";
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
    if(address.vArea.isNotEmpty){
      return "Area: ${address.vArea}, Block No: ${address.vBlockNo}, Road No: ${address.vRoadNo}, Building No: ${address.vBuildingNo}, Flat No: ${address.vFlatNo}";
    }
    else{
      return "";
    }
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