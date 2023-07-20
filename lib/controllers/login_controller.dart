import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import 'package:hitechpos/services/createbaseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController registrationKeyController = TextEditingController();
  late TextEditingController registrationPortController = TextEditingController();
  late TextEditingController registrationDomainController = TextEditingController();

  final secureText = true.obs ;
  final isRememberMe = false.obs;
  final isRegistrationSuccessfull = false.obs; 

  late FocusNode userNameFocus,passwordFocus,registrationKeyFocus,
  registrationSchemaFocus,registrationPortFocus,registrationDomainFocus;

  List<String> schemaValueList = ["Select schema","https","http"];
  final selectedSchema = "Select schema".obs;
  String baseurlFromLocalStorage = "";
  String registrationKeyFromLocalStorage = "";
  @override

  void onInit() async{
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    registrationKeyFocus = FocusNode();
    registrationSchemaFocus = FocusNode();
    registrationPortFocus = FocusNode();
    registrationDomainFocus = FocusNode();
    _loadUserNameAndPassword();
    setRegistrationInformationFromLocalstorage();
    setBaseUrl();
    super.onInit();
  }
  
  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    registrationKeyController.dispose();
    userNameFocus.dispose();
    passwordFocus.dispose();
    registrationKeyFocus.dispose();

    super.onClose();
  }
  void visibilityOfSecureText( bool visibility){
    secureText(visibility);
  }

  void setisRememberMe(bool remember){
    isRememberMe(remember);
  }

  void setSelectedSchema(String schema){
    selectedSchema.value = schema;
  }
  // call for refresh loging screen fileds if remember me is false
  refreshTextField(){
    userNameController.text = "";
    passwordController.text = "";
  }
  ///Load from local storage Username and password
  void _loadUserNameAndPassword() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var  username = prefs.getString("username") ?? ""; 
      var  password = prefs.getString("password") ?? ""; 
      var  rememberMe = prefs.getBool("remember_me") ?? false;
      debugPrint(username);
      debugPrint(password);
      debugPrint(rememberMe.toString());
      
      if(rememberMe){
        isRememberMe(rememberMe);
      }
      userNameController.text = username;
      passwordController.text = password;
    } 
    catch (e) {
      debugPrint(e.toString());
    }
  }
  ///When check box clicked then load data into local storage  
  void handleRemember(bool value){
    isRememberMe(value);
    SharedPreferences.getInstance().then((prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString("username", userNameController.text);
        prefs.setString("password", passwordController.text);
      }
    );
  }
  
  // set Registration information from localstorage
  void setRegistrationInformationFromLocalstorage() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var registrationSchema = prefs.getString("schema");
      var registrationDomain = prefs.getString("domain");
      var registrationPort = prefs.getString("port");
      var registrationKey = prefs.getString("registrationkey");
      if(registrationKey!.isNotEmpty && 
        registrationPort!.isNotEmpty && 
        registrationDomain!.isNotEmpty && 
        registrationSchema!.isNotEmpty){
        isRegistrationSuccessfull(true);
      }
      setSelectedSchema(registrationSchema!);
      registrationDomainController.text = registrationDomain!;
      registrationPortController.text = registrationPort!;
      registrationKeyController.text = registrationKey;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //set Registration information from localstorage
  void checkRegistrationInformationIntoLocalstorage() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var registrationSchema = prefs.getString("schema");
      var registrationDomain = prefs.getString("domain");
      var registrationPort = prefs.getString("port");
      var registrationKey = prefs.getString("registrationkey");
      if(registrationKey!.isNotEmpty && 
        registrationPort!.isNotEmpty && 
        registrationDomain!.isNotEmpty && 
        registrationSchema!.isNotEmpty){
        isRegistrationSuccessfull(true);
        setBaseUrl();
      }
      else{
        isRegistrationSuccessfull(false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // save Registration key
  void saveRegistrationInformationInLocal(String schema,String domain,String port,String key){
    if(isRegistrationSuccessfull.value){
      SharedPreferences.getInstance().then((prefs) {
          prefs.setString("schema", schema);
          prefs.setString("port", port);
          prefs.setString("domain", domain);
          prefs.setString("registrationkey", key);
        }
      );
      Get.snackbar("Successfull", "Your registration information save successfully",snackPosition: SnackPosition.BOTTOM);
    }
  }
  
  void setBaseUrl () async{
    try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var registrationSchema = prefs.getString("schema");
    var registrationDomain = prefs.getString("domain");
    var registrationPort = prefs.getString("port");
    var registrationKey = prefs.getString("registrationkey");
    baseurlFromLocalStorage = CreateBaseUrl().createBaseUrl(registrationSchema!, registrationDomain!, registrationPort!);
    registrationKeyFromLocalStorage = registrationKey!;
    } 
    catch (e) {
      debugPrint(e.toString());
    }
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
  Future<void> login(String username, String password) async {
    try {
      checkRegistrationInformationIntoLocalstorage();
      if(isRegistrationSuccessfull.value){
        String baseurl = baseurlFromLocalStorage;
        final url = Uri.parse('${baseurl}api/login');
        final headers = {
          'Key': registrationKeyFromLocalStorage,
          'Content-Type': 'application/json',
        };
        final body = jsonEncode({
          'Username': username,
          'Password': password,
        });

        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          if(data['messageId'] == '200'){
            Get.offAll(const DashboardScreen());
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
}