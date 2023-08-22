import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/models/branchinfo.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import 'package:hitechpos/services/createbaseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';

class LoginController extends GetxController {

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController registrationKeyController = TextEditingController();
  late TextEditingController registrationPortController = TextEditingController();
  late TextEditingController registrationDomainController = TextEditingController();

  final secureText = true.obs ;
  final isRememberMe = false.obs;
  final isRegistrationSuccessfull = false.obs;
  final isSaveRegistrationData = false.obs;

  late FocusNode userNameFocus,passwordFocus,registrationKeyFocus,loginBranchFocus,
  registrationSchemaFocus,registrationPortFocus,registrationDomainFocus;

  List<String> schemaValueList = ["Select schema","https","http"];
  final selectedSchema = "Select schema".obs;
  String baseurlFromLocalStorage = "";
  String registrationKeyFromLocalStorage = "";
  String branchIdFromLocalStorage = "";
  String userIdFromLocalStorage = "";
  var isBranchLoding = true.obs;
  Rx<List<BranchInfo>> branchModel= Rx<List<BranchInfo>>([]);
  Rx<List<BranchList>> branchList= Rx<List<BranchList>>([]);
  Rx<List<DropdownMenuItem<String>>> branchDropdownItemMenu = Rx<List<DropdownMenuItem<String>>>([]);
  var selectedBranchId = "0".obs;
  bool baseUrlLoading = false;

  late String invoiceId = "";
  late String invoiceNo = "";

  get getInvoiceId => invoiceId;
  get getInvoiceNo => invoiceNo;

  set setInvoiceId(String invoiceId){
    this.invoiceId = invoiceId;
  }
  set setInvoiceNo(String invoiceNo){
    this.invoiceNo = invoiceNo;
  }
  
  @override
  void onInit() async{
    super.onInit();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    registrationKeyFocus = FocusNode();
    registrationSchemaFocus = FocusNode();
    registrationPortFocus = FocusNode();
    registrationDomainFocus = FocusNode();
    loginBranchFocus = FocusNode();
    // if(isRememberMe.value){
     
    // }
    _loadUserNameAndPassword();
    setRegistrationInformationFromLocalstorage();
  }

  // @override
  // void onReady(){
  //   super.onReady();

  // }
  
  @override
  void onClose() {
    //userNameController.dispose();
    //passwordController.dispose();
    //registrationKeyController.dispose();
    //userNameFocus.dispose();
   // passwordFocus.dispose();
   // registrationKeyFocus.dispose();
    
    super.onClose();
  }
  void getBranch(){
    try {
      fatchBranchInfo().then((value) {
        if(value.branchList.isNotEmpty){
          isBranchLoding.value = true;
          branchList.value.clear();
          branchList.value.addAll(value.branchList);
          branchDropdownItemMenu.value = [];
          branchDropdownItemMenu.value.add(
            const DropdownMenuItem(
              value: "0",
              child: Text('Select Branch',
                style: TextStyle(
                  fontFamily: Palette.layoutFont,
                ),
              ),
            ),
          );
          for(BranchList branch in branchList.value){
              branchDropdownItemMenu.value.add(
                DropdownMenuItem(
                  value: branch.vBranchId,
                  child: Text(branch.vBranchName,
                  style: const TextStyle(
                      fontFamily: Palette.layoutFont,
                    ),
                  ),
                ),
              );
            }
            isBranchLoding.value = false;
            if(isRememberMe.value){
              selectBranchfromLocalStorage();
            }
          }
      }).onError((error, stackTrace) {
          debugPrint("failed branch load");
        }
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void visibilityOfSecureText( bool visibility){
    secureText(visibility);
  }
  void setisRememberMe(bool remember){
    isRememberMe(remember);
  }
  void setSelectedBranch(var branch){
    selectedBranchId.value = branch;
  }
  void setSelectedSchema(String schema){
    selectedSchema.value = schema;
  }
  // call for refresh loging screen fileds if remember me is false
  refreshTextField(){
    userNameController.text = "";
    passwordController.text = "";
    selectedBranchId.value = "0";
  }
  //Load Baranch from api
  Future<BranchInfo> fatchBranchInfo() async {
    String baseurl = baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/branch");
    debugPrint(url.toString());
    final headers = {
      'Key': registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
      return BranchInfo.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load branch');
    }
  }

  //select branch if has local storage 
  void selectBranchfromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      var  branchId = prefs.getString(SharedPreferencesKeys.loginBranch.name) ?? "0"; 
      if(branchId != "0"){
        selectedBranchId.value = branchId;
      }
  }
  ///Load from local storage Username and password 
  void _loadUserNameAndPassword() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var  username = prefs.getString(SharedPreferencesKeys.loginUserName.name) ?? ""; 
      var  password = prefs.getString(SharedPreferencesKeys.loginPassword.name) ?? ""; 
      var  rememberMe = prefs.getBool(SharedPreferencesKeys.rememberMe.name) ?? false;
      debugPrint(username);
      debugPrint(password);
      debugPrint(rememberMe.toString());
      
      if(rememberMe){
        isRememberMe.value = rememberMe;
        userNameController.text = username;
        passwordController.text = password;
      }
      else{
        userNameController.text = "";
        passwordController.text = "";
      }

    } 
    catch (e) {
      debugPrint(e.toString());
    }
  }
  ///When check box clicked then load data into local storage  
  void handleRemember(bool value){
    isRememberMe.value = value;
    SharedPreferences.getInstance().then((prefs) {
          prefs.setBool(SharedPreferencesKeys.rememberMe.name, value);
          prefs.setString(SharedPreferencesKeys.loginUserName.name, userNameController.text);
          prefs.setString(SharedPreferencesKeys.loginPassword.name, passwordController.text);
          if(selectedBranchId.value.isNotEmpty){
            prefs.setString(SharedPreferencesKeys.loginBranch.name, selectedBranchId.value);
          }
          if(isRememberMe.value){
            prefs.setBool(SharedPreferencesKeys.autoLogin.name, true);
          }
          else{
            prefs.setBool(SharedPreferencesKeys.autoLogin.name, false);
          }
        }
    );

    // else{
    //   SharedPreferences.getInstance().then((prefs) {
    //       prefs.setBool("remember_me", value);
    //       prefs.setString("username", "");
    //       prefs.setString("password", "");
    //       if(selectedBranchId.value.isNotEmpty){
    //         prefs.setString("branch_Id", "0");
    //       }
    //       prefs.setBool("autoLogin", false);
    //     }
    //   );
    // }
  }
  // bool checkUserInformationForGoToDashBoardAutomatically(){
  //   checkRegistrationInformationIntoLocalstorage();
  //   selectBranchfromLocalStorage();
  //   _loadUserNameAndPassword();
  //   if(isRegistrationSuccessfull.value && 
  //     selectedBranchId.value != "0" &&
  //     isRememberMe.value)
  //   {
  //     return true;
  //   }
  //   else{
  //     return false;
  //   }
  // }
  // set Registration information from localstorage
  void setRegistrationInformationFromLocalstorage() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var registrationSchema = prefs.getString(SharedPreferencesKeys.schema.name);
      var registrationDomain = prefs.getString(SharedPreferencesKeys.domain.name);
      var registrationPort = prefs.getString(SharedPreferencesKeys.port.name);
      var registrationKey = prefs.getString(SharedPreferencesKeys.registrationkey.name);
      isRegistrationSuccessfull.value = prefs.getBool(SharedPreferencesKeys.isregistration.name)! ;

      if(registrationKey!.isNotEmpty && 
        registrationPort!.isNotEmpty && 
        registrationDomain!.isNotEmpty && 
        registrationSchema!.isNotEmpty 
        ){
        isRegistrationSuccessfull(true);
      }
      setSelectedSchema(registrationSchema!);
      registrationDomainController.text = registrationDomain!;
      registrationPortController.text = registrationPort!;
      registrationKeyController.text = registrationKey;
      if(isRegistrationSuccessfull.value){
        setBaseUrl();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //set Registration information from localstorage
  void checkRegistrationInformationIntoLocalstorage() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var registrationSchema = prefs.getString(SharedPreferencesKeys.schema.name);
      var registrationDomain = prefs.getString(SharedPreferencesKeys.domain.name);
      var registrationPort = prefs.getString(SharedPreferencesKeys.port.name);
      var registrationKey = prefs.getString(SharedPreferencesKeys.registrationkey.name);
      if(registrationKey!.isNotEmpty && 
        registrationPort!.isNotEmpty && 
        registrationDomain!.isNotEmpty && 
        registrationSchema!.isNotEmpty &&
        isRegistrationSuccessfull.value
        ){
        isRegistrationSuccessfull(true);
        setBaseUrl();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // check login information from Localstorage
  void checkLoginInformationIntoLocalstorage(){
      if(isRememberMe.value){

      }
  }
  // save Registration key
  void saveRegistrationInformationInLocal(String schema,String domain,String port,String key){
    if(isRegistrationSuccessfull.value){
      SharedPreferences.getInstance().then((prefs) {
          prefs.setString(SharedPreferencesKeys.schema.name, schema);
          prefs.setString(SharedPreferencesKeys.port.name, port);
          prefs.setString(SharedPreferencesKeys.domain.name, domain);
          prefs.setString(SharedPreferencesKeys.registrationkey.name, key);
          prefs.setBool(SharedPreferencesKeys.isregistration.name, true);
        }
      );
      //setBaseUrl();
      isSaveRegistrationData.value = true;
      setRegistrationInformationFromLocalstorage();
      setBaseUrl();
      Get.snackbar("Successfull", "Your registration information save successfully",snackPosition: SnackPosition.BOTTOM);
      
    }
  }
  
  Future setBaseUrl() async{
    //getBranch();
    try {
      baseUrlLoading = true;
      debugPrint("base Url call");
      //setRegistrationInformationFromLocalstorage();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var registrationSchema = prefs.getString(SharedPreferencesKeys.schema.name);
      var registrationDomain = prefs.getString(SharedPreferencesKeys.domain.name);
      var registrationPort = prefs.getString(SharedPreferencesKeys.port.name);
      var registrationKey = prefs.getString(SharedPreferencesKeys.registrationkey.name);
      var branchId = prefs.getString(SharedPreferencesKeys.loginBranch.name);
      var userId = prefs.getString(SharedPreferencesKeys.vUserId.name);
      baseurlFromLocalStorage = CreateBaseUrl().createBaseUrl(registrationSchema!, registrationDomain!, registrationPort!);
      registrationKeyFromLocalStorage = registrationKey!;
      branchIdFromLocalStorage = branchId!;
      userIdFromLocalStorage = userId!;
      debugPrint("${baseurlFromLocalStorage}Empty");
      baseUrlLoading = false;
    } 
    catch (e) {
      debugPrint(e.toString());
    }
    getBranch();
  }
  
  // for Services class 
  // Registration data
  Future<void> registrationTest(String registrationkey) async {
    try {
      String  baseurl = CreateBaseUrl().createBaseUrl(selectedSchema.value, registrationDomainController.text, registrationPortController.text);
      final url = Uri.parse('${baseurl}api/config?flag=getapikeystatus');

      final headers = {
        'Key': registrationkey,
        'Content-Type': 'application/json',
      };

      final response = await http.post(url, headers: headers);
      if (response.statusCode  == 200) {
        var data = jsonDecode(response.body.toString());
        if(data['messageId'] == '200'){
          isRegistrationSuccessfull(true);
          //setBaseUrl();
          Get.snackbar("Information", "Registration Successfull",snackPosition: SnackPosition.BOTTOM);
        }
        else{
          Get.snackbar("Invalid", "Please provide valid information",snackPosition: SnackPosition.BOTTOM);
        }
      }
    } 
    catch (e) {
      debugPrint('Error: $e');
    }
  }

  // login check
  Future<void> login(String username, String password, String branchId) async {
    try {
      checkRegistrationInformationIntoLocalstorage();
      if(isRegistrationSuccessfull.value){
        String branchId = "";
        if(selectedBranchId.value.isNotEmpty){
          branchId = selectedBranchId.value;
        }
        String baseurl = baseurlFromLocalStorage;
        final url = Uri.parse('${baseurl}api/login');
        final headers = {
          'Key': registrationKeyFromLocalStorage,
          'Content-Type': 'application/json',
        };
        
        final body = jsonEncode({
          "BranchId": branchId,
          'Username': username,
          'Password': password,
        });

        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          debugPrint(data.toString());
          if(data['messageId'] == '200'){
            SharedPreferences.getInstance().then((prefs) {
                prefs.setString(SharedPreferencesKeys.vUserId.name, data[SharedPreferencesKeys.vUserId.name]);
                prefs.setString(SharedPreferencesKeys.vFullName.name, data[SharedPreferencesKeys.vFullName.name]);
                prefs.setString(SharedPreferencesKeys.dExpiryDate.name, data[SharedPreferencesKeys.dExpiryDate.name]);
                prefs.setString(SharedPreferencesKeys.vMobileNo.name, data[SharedPreferencesKeys.vMobileNo.name]);
                prefs.setString(SharedPreferencesKeys.vEmailId.name, data[SharedPreferencesKeys.vEmailId.name]);
                prefs.setString(SharedPreferencesKeys.vEmployeeId.name, data[SharedPreferencesKeys.vEmployeeId.name]);
                prefs.setString(SharedPreferencesKeys.dLastLogin.name, data[SharedPreferencesKeys.dLastLogin.name]);
                prefs.setString(SharedPreferencesKeys.rendomNumberForOrderId.name, data["vUniqueId"]);
              }
            );
            handleRemember(isRememberMe.value);
            Get.to(() => const DashboardScreen());
          }
          else{
            Get.snackbar("Error", "Incorrect username or password",snackPosition: SnackPosition.BOTTOM);
          }
        } 
        else {
          Get.snackbar("Error",'Login Failed - Status Code: ${response.statusCode}',snackPosition: SnackPosition.BOTTOM);
        }
      }
      else{
        Get.snackbar("Information", "Please register your account",snackPosition: SnackPosition.BOTTOM);
      }
    } 
    catch (e) {
      debugPrint('Error: $e');
    }
  }

    Future<bool> isUserValid(String username, String password, String branchId) async {
    try {
      String baseurl = baseurlFromLocalStorage;
      final url = Uri.parse('${baseurl}api/login');
      final headers = {
        'Key': registrationKeyFromLocalStorage,
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        "BranchId": branchId,
        'Username': username,
        'Password': password,
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint(data.toString());
        if(data['messageId'] == '200'){
          SharedPreferences.getInstance().then((prefs) {
              prefs.setString(SharedPreferencesKeys.rendomNumberForOrderId.name, data["vUniqueId"]);
            }
          );
          return true;
        }
      } 
      else {
        Get.snackbar("Error",'Login Failed - Status Code: ${response.statusCode}',snackPosition: SnackPosition.BOTTOM);
      }
    } 
    catch (e) {
      debugPrint('Error: $e');
    }
    return false;
  }

}