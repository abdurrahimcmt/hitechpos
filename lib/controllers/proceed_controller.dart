import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/customnotification.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/customer_and_address_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/data/notificationdata.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/models/invoiceinfodetails.dart';
import 'package:hitechpos/views/proceedorder/ordersuccessful.dart';
import 'package:hitechpos/widgets/loading_prograss_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProceedController extends GetxController {

  final loginController = Get.find<LoginController>();
  final menuController = Get.find<MenuScreenController>();
  final customerAndAddressController = Get.find<CustomerAndAddressController>();
  final diniInController = Get.find<DiniInController>();
  final cartController = Get.find<CartController>();

  var uniqueId = "";
  final isDataLoading = true.obs;
  final isProceedStart = false.obs;
  bool isReportPrint = false;

  String selectedOrderTypeName = "";

  String selectedTableForParam = "";
  String selectedFloorForParam = "";
  bool valid = true;
  String customerId = "";
  String customerAddress = "";
  String carNumber = "";

  InvoiceReportModel invoiceReportData = InvoiceReportModel(messageId: "", message: "", returnValue: "",
   invoiceId: "", invoiceNo: "", billAmount: 0.00, reportDetails: []);
 
  @override
  void onInit(){
    //setOrderTypeData(menuController.selectedOrderType.value);
    customerAndAddressController.selectedCustomertext.value = TextEditingValue(text: customerAndAddressController.getSelectedCustomer().vCustomerName);
    customerAndAddressController.selectedAddress.value = TextEditingValue(text: customerAndAddressController.combinedCustomerAddressFields(customerAndAddressController.getSelectedCustomerAddress()));
    customerAndAddressController.setCustomerList();
    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
    customerAndAddressController.setCustomerList();
  }
  void setOrderTypeData(int orderTypeIndex){
    debugPrint("setOrderTypeData $orderTypeIndex");
    selectedOrderTypeName = orderTypes[orderTypeIndex].name;
    
    if(selectedOrderTypeName == "Dine In"){
      //refreshProceedController();
    }
    else if(selectedOrderTypeName == "Take Away"){
     // refreshProceedController();
      if(customerAndAddressController.selectedCustomer.value.vCustomerId.isNotEmpty){
        customerAndAddressController.selectedCustomer = customerAndAddressController.selectedCustomer;
      }

    }
    else if(selectedOrderTypeName == "Delivery"){
     // refreshProceedController();
      if(customerAndAddressController.selectedCustomer.value.vCustomerId.isNotEmpty){
        customerAndAddressController.selectedCustomer = customerAndAddressController.selectedCustomer;
      }
      if(customerAndAddressController.selectedCustomerAddress.vArea.isNotEmpty){
        customerAndAddressController.selectedCustomerAddress = customerAndAddressController.selectedCustomerAddress;
      }
    }
    else if(selectedOrderTypeName == "Drive Through"){
     // refreshProceedController();
      if(customerAndAddressController.selectedCustomer.value.vCustomerId.isNotEmpty){
        customerAndAddressController.selectedCustomer = customerAndAddressController.selectedCustomer;
      }
      if(customerAndAddressController.selectedCustomerAddress.vArea.isNotEmpty){
        customerAndAddressController.selectedCustomerAddress = customerAndAddressController.selectedCustomerAddress;
      }
      if(customerAndAddressController.carNumberController.text.isNotEmpty){
        customerAndAddressController.carNumberController.text = customerAndAddressController.carNumberController.text;
      }
      customerAndAddressController.selectedCustomertext.value = TextEditingValue(text: customerAndAddressController.getSelectedCustomer().vCustomerName);
      customerAndAddressController.selectedAddress.value = TextEditingValue(text: combinedCustomerAddressFields(customerAndAddressController.getSelectedCustomerAddress()));
    }
  }

  void orderProceeedValidation(int selectedOrderType){

    if(selectedOrderType == 0){
      if(diniInController.selectedTable.value.vTableId.isNotEmpty){
        selectedFloorForParam = diniInController.selectedFloor.value.iFloorId;
        selectedTableForParam = diniInController.selectedTable.value.vTableId;
        valid = true;
        customerId = "";
        customerAddress = "";
        carNumber = "";
      }
      else{
        //Get.snackbar("Error", "Please select table",snackPosition: SnackPosition.BOTTOM);
        CustomNotification().notification(NotificationData.error.name, "Error", "Please select table", "bottom");
        valid = false;
      }
    }
    else if(selectedOrderType == 1){
      customerId = customerAndAddressController.getSelectedCustomer().vCustomerId;
      selectedFloorForParam = "";
      selectedTableForParam = "";
      customerAddress = "";
      carNumber = "";
      valid = true;
    }
    else if(selectedOrderType == 2){
      customerId = customerAndAddressController.getSelectedCustomer().vCustomerId;
      customerAddress = customerAndAddressController.getSelectedCustomerAddress().vArea;  
      if(customerId.isNotEmpty){
        if(customerAddress.isNotEmpty){
          customerAddress = customerAndAddressController.combinedCustomerAddressFields(customerAndAddressController.getSelectedCustomerAddress());
          selectedFloorForParam = "";
          selectedTableForParam = "";
          carNumber = "";
          valid = true;
        }
        else{
          //Get.snackbar("Error", "Please select Address", snackPosition: SnackPosition.BOTTOM);
          CustomNotification().notification(NotificationData.error.name, "Error", "Please select address", "bottom");
          valid = false;
        }
      }
      else{
        //Get.snackbar("Error", "Please select Customer", snackPosition: SnackPosition.BOTTOM);
        CustomNotification().notification(NotificationData.error.name, "Error", "Please select customer", "bottom");
        valid = false;
      }
    }
    else if (selectedOrderType == 3){
      customerId = customerAndAddressController.getSelectedCustomer().vCustomerId;
      customerAddress = customerAndAddressController.combinedCustomerAddressFields(customerAndAddressController.getSelectedCustomerAddress());
      carNumber = customerAndAddressController.carNumberController.text;
        selectedFloorForParam = "";
        selectedTableForParam = "";
        valid = true;
    }
    else{
      selectedFloorForParam = "";
      selectedTableForParam = "";
      customerId = "";
      customerAddress = "";
      carNumber = "";
    }
    if(valid){
      isProceedStart.value = true;
      Get.to(() => LoadingPrograssScreen());
      Future<InvoiceInfoDetails> invoiceData = cartController.getInvoiceInfoDetails(
        selectedOrderType + 1,
          selectedFloorForParam,
          selectedTableForParam, 
          customerId,
          customerAddress,
          carNumber
      );
      proceedOrderPostRequest(invoiceData);
    }
  }
  
  void refreshProceedController(){
    selectedFloorForParam = "";
    selectedTableForParam = "";
    valid = true;
    customerId = "";
    customerAddress = "";
    carNumber = "";
    customerAndAddressController.selectedCustomer.value = CustomerList(vBranchId: "", vCustomerId: "", 
    vCustomerCode: "", vCustomerName: "", vVatRegNo: "", vMobileNo: "", vEmailId: "", 
    iCreditLimit: 0, iActive: 0, vCreatedBy: "", dCreatedDate: DateTime.now(), vModifiedBy: "", 
    dModifiedDate: DateTime.now());

    customerAndAddressController.selectedCustomerAddress = CustomerAddressList(vCustomerId: "", vAddId: "",
    vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: "");

    customerAndAddressController.carNumberController.text = "";
    
  }

  String combinedCustomerAddressFields(CustomerAddressList address){
    if(address.vArea.isNotEmpty){
      return "Area: ${address.vArea}, Block No: ${address.vBlockNo}, Road No: ${address.vRoadNo}, Building No: ${address.vBuildingNo}, Flat No: ${address.vFlatNo}";
    }
    else{
      return "";
    }
  }

  Future<bool> checkUserValidity() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var  username = prefs.getString(SharedPreferencesKeys.loginUserName.name) ?? ""; 
      var  password = prefs.getString(SharedPreferencesKeys.loginPassword.name) ?? "";
      var  branchId = prefs.getString(SharedPreferencesKeys.loginBranch.name) ?? "";

      if(await loginController.isUserValid(username, password, branchId)){
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<void> proceedOrderPostRequest(Future<InvoiceInfoDetails> invoiceData) async{

    if(await checkUserValidity()){
      String jsonData = invoiceInfoDetailsToJson(await invoiceData);
      String baseurl = loginController.baseurlFromLocalStorage;
      final url = Uri.parse('${baseurl}api/invoice/app');
      debugPrint(url.toString());
      debugPrint(loginController.registrationKeyFromLocalStorage);
      debugPrint(jsonData);
      
      final headers = {
        'Key': loginController.registrationKeyFromLocalStorage,
        'Content-Type': 'application/json',
        'mbserial': '94-E9-79-CB-E9-A3'
      };

      final body = jsonData;
      debugPrint(body);
      final response = await http.post(url, headers: headers, body: body);

      if(response.statusCode == 200){

        debugPrint("responce 200");
        var data = jsonDecode(response.body);
        debugPrint(response.body);

        if(data['messageId'] == '200'){
          final Map<String, dynamic> jsonData = json.decode(response.body);
          invoiceReportData = InvoiceReportModel.fromJson(jsonData);

          debugPrint(invoiceReportData.toString());
          isReportPrint = true;
          Get.to(() => OrderSuccessfulScreen(), arguments: Future.value(invoiceReportData));
          isProceedStart.value = false;
        }
      }
    }
  }
  
}