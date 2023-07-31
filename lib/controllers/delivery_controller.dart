import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:http/http.dart' as http;


class DeliveryController extends GetxController {

  final loginController = Get.find<LoginController>();
  final isDataLoading = true.obs;
  //late Future<CustomerInfo> customerInfo;
  late List<CustomerList> customerList;
  late TextEditingController customerTextController = TextEditingController();
  //late Rx<TextEditingController> addressTextController = TextEditingController().obs;

  //var selectedAddressId = "0".obs;
  late CustomerList selectedCustomer;

  late RxList<CustomerAddressList> customerAddressList = <CustomerAddressList>[].obs;
  //Rx<List<CustomerAddressList>> customerAddressList= Rx<List<CustomerAddressList>>([]);
 // Rx<List<DropdownMenuItem<String>>> addressDropdownItemMenu = Rx<List<DropdownMenuItem<String>>>([]);
  late String selectedCustomerAddress = "0-B0001C1";

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

  //   void getCustomerAddress(String customerId){
  //   try {
  //     fatchAddressInfo(customerId).then((value) {
  //       if(value.customerAddressList.isNotEmpty){
  //         isDataLoading.value = false;
  //         customerAddressList.value.clear();
  //         customerAddressList.value.addAll(value.customerAddressList);
  //         addressDropdownItemMenu.value = [];
  //         addressDropdownItemMenu.value.add(
  //           const DropdownMenuItem(
  //             value: "0",
  //             child: Text('Select Address',
  //               style: TextStyle(
  //                 fontFamily: Palette.layoutFont,
  //               ),
  //             ),
  //           ),
  //         );
  //         for(CustomerAddressList address in customerAddressList.value){
  //             addressDropdownItemMenu.value.add(
  //               DropdownMenuItem(
  //                 value: address.vAddId,
  //                 child: Text(combinedCustomerAddressFields(address),
  //                 style: const TextStyle(
  //                     fontFamily: Palette.layoutFont,
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }
  //           isDataLoading.value = false;
  //         }
  //     }).onError((error, stackTrace) {
  //         debugPrint("failed to load address");
  //       }
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

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

  void setSelectedCustomerAddress(String address){
    selectedCustomerAddress = address;
  }

  String getSelectedCustomerAddress(){
    return selectedCustomerAddress;
  }

  String combinedCustomerAddressFields(CustomerAddressList address){
    return "Area: ${address.vArea}, Block No: ${address.vBlockNo}, Road No: ${address.vRoadNo}, Building No: ${address.vBuildingNo}, Flat No: ${address.vFlatNo}";
  }

  Future<CustomerAddress> fatchAddressInfo(String customer) async{
    String baseurl = loginController.baseurlFromLocalStorage;
    // https://hiposbh.com:84/api/waiterapp/cusaddress/B0001C1
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