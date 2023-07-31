import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/models/invoicenotes.dart';
import 'package:hitechpos/models/itemdetails.dart';
import 'package:hitechpos/models/kitchennotes.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController{
  final loginController = Get.find<LoginController>();
  late Future<KitchenNotes> kitchenNoteList;
  late Future<InvoiceNotes> invoiceNoteList;
  final itemdetailsIsloading = true.obs;
  
  //late ItemList item;   
  // final TextEditingController txtKitchenNotesController = TextEditingController();
  // final TextEditingController txtInvoiceNotesController = TextEditingController();
  // final TextEditingController txtQuntityController = TextEditingController();
 // final selectedFoodItemSizeIndex = 0.obs;
  //final orderQuentity = 1.obs;
 // List<String> isSelectedModifier = <String>[].obs;
//  List<String> isSelectedKitchenNotes = <String>[].obs;
 // String concatedKitchenNotes= "";
 // List<String> isSelectedInvoiceNotes = <String>[].obs;
 // String concatedInvoiceNotes= "";
 // final modifierTotalPrice = 0.000.obs;
 // final price = 0.000.obs;

  // void refreshOrderQuentity(){
  //   orderQuentity.value = 1;
  // }
  // void quentityAction(){
  //   if(txtQuntityController.text.isEmpty ||  int.parse( txtQuntityController.text) < 1 ){
  //     txtQuntityController.text = "1";
  //     Get.snackbar("Worning", "Quentity must be getter then 0");
  //   }
  //   orderQuentity.value = int.parse(txtQuntityController.text);
  // }
  // void refreshPrice(){
  //   price.value = double.parse(item.vItemPrice)  + modifierTotalPrice.value;
  // }
  // void modifierAction(String modifierName,double modifierPrice){
  //   if(!isSelectedModifier.contains(modifierName)){
  //     isSelectedModifier.add(modifierName);
  //     modifierTotalPrice.value = modifierTotalPrice.value + modifierPrice;
  //     refreshPrice();
  //   }
  //   else{
  //     isSelectedModifier.remove(modifierName);
  //     modifierTotalPrice.value = modifierTotalPrice.value - modifierPrice;
  //     refreshPrice();
  //   }
  // }
  // void refreshChichenNotes(){
  //   concatedKitchenNotes = isSelectedKitchenNotes.join(", ");
  //   txtKitchenNotesController.text = concatedKitchenNotes;
  // }
  // void refreshInvoiceNotes(){
  //   concatedInvoiceNotes = isSelectedInvoiceNotes.join(", ");
  //   txtInvoiceNotesController.text = concatedInvoiceNotes;
  // }

  @override
  void onInit(){
    //item = Get.arguments as ItemList;
    //refreshOrderQuentity();
   // price.value = double.parse(item.vItemPrice)  + modifierTotalPrice.value;
    //txtQuntityController.text = orderQuentity.toString();
    // concatedKitchenNotes = isSelectedKitchenNotes.join(", ");
    // concatedInvoiceNotes = isSelectedInvoiceNotes.join(", ");
    // txtKitchenNotesController.text = concatedKitchenNotes;
    // txtInvoiceNotesController.text = concatedInvoiceNotes;
    super.onInit();
    kitchenNoteList = fatchKitchenNotes();
    invoiceNoteList = fatchInvoiceNotes();
  }
  // Future<void> fatchItemDetails(String itemId) async {
  //   itemdetailsIsloading.value = true;
  //   String baseurl = loginController.baseurlFromLocalStorage;
  //   debugPrint(baseurl);
  //   //https://hiposbh.com:84/api/waiterapp/itemlist/all/no/B0001
  //   final url = Uri.parse("${baseurl}api/waiterapp/itemdetails/$itemId");
  //   debugPrint(url.toString());
  //   final headers = {
  //     'Key': loginController.registrationKeyFromLocalStorage.toString(),
  //     'Content-Type': 'application/json'
  //   };
  //   final response = await http.get(url,headers: headers);
  //   if(response.statusCode == 200){
  //       //return ItemInfo.fromJson(jsonDecode(response.body));
  //       itemDetails = itemDetailsFromJson(response.body);
  //   }
  //   else{
  //     itemdetailsIsloading.value= false;
  //     throw Exception('Failed to load Item');
  //   }
  //   itemdetailsIsloading.value= false;
  // }

  Future<ItemDetails> fatchItemDetails(String itemId) async {
    
    itemdetailsIsloading.value = true;
    String baseurl = loginController.baseurlFromLocalStorage;
    
    final url = Uri.parse("${baseurl}api/waiterapp/itemdetails/$itemId");
    debugPrint(url.toString());

    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };

    final response = await http.get(url,headers: headers);
    itemdetailsIsloading.value = false;

    if(response.statusCode == 200){
        return ItemDetails.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Invoice Notes');
    }
    
  }


  Future<InvoiceNotes> fatchInvoiceNotes() async {
    String baseurl = loginController.baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/notelist/inv");
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        return InvoiceNotes.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Invoice Notes');
    }
  }

  Future<KitchenNotes> fatchKitchenNotes() async {
    String baseurl = loginController.baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/notelist/kit");
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        return KitchenNotes.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Kitchen Notes');
    }
  }
  @override
  void onReady(){
    refreshController();
  }
  void refreshController() {
    //orderQuentity.value = 1;
    // isSelectedModifier.clear();
    // isSelectedKitchenNotes.clear();
    // isSelectedInvoiceNotes.clear();
    //modifierTotalPrice.value = 0.000;
   // price.value = double.parse(item.vItemPrice);
    // txtKitchenNotesController.text = '';
    // txtInvoiceNotesController.text = '';
  }
  @override
  void onClose(){
    // txtKitchenNotesController.dispose();
    // txtInvoiceNotesController.dispose();
    // txtQuntityController.dispose();
    super.onClose();
  }
  
}