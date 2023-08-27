import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/cartDetailsmodel.dart';
import 'package:hitechpos/models/invoiceinfodetails.dart';
import 'package:hitechpos/models/itemdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController{

  //This list maintain the cart data
  Rx< List<CartDetailsModel> > cartDetailsModelList = Rx<List<CartDetailsModel>>([]);
  final loginController = Get.find<LoginController>();
  //final orderListController = Get.find<OrderListController>();
  double totalBillAmount = 0.000;
  String uniqueId = "";
  bool isDataUpdate = false;

  void refreshCartController(){
      totalBillAmount = 0.000;
      uniqueId = "";
      isDataUpdate = false;
  }

  Future<String> getDeviceinfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    debugPrint('Running on ${androidInfo.id}'); 
    return androidInfo.device.toString();
    //Get.snackbar("DeviceId", 'DeviceId ${androidInfo.id}');
  }

  Future<String> getUniqueId() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uniqueId = prefs.getString(SharedPreferencesKeys.rendomNumberForOrderId.name)!;
    } catch (e) {
      debugPrint(e.toString());
    }
    return uniqueId;
  }

  void addToCart(
  String itemId,
  String itemName,
  int orderedQty,
  //mFinalPrice of ItemPriceList
  double mFinalPrice,
  double totalPrice,
  double discountAmount,
  String vatCatId,
  String vatCatOption,
  double vatPercent,

  String vUnitId,
  String vUnitName,

  double mMainPrice,
  double mVatAmount,
  double mWoVatAmount,
  

 // ItemPriceList itemPriceList,
  List<OnlineModifierList> onlineModifierLists,
  String combinedKitchenNotesText,
  String combinedInvoiceNotesText)
  {
    cartDetailsModelList.value.add(  
      CartDetailsModel(itemId: itemId, itemName: itemName,orderedQty: orderedQty, mFinalPrice: mFinalPrice, totalPrice: totalPrice,
      discountAmount: discountAmount,vatCatId: vatCatId,vatCatOption: vatCatOption,vatPercent: vatPercent,
       onlineModifierLists: onlineModifierLists,
      combinedKitchenNotesText: combinedKitchenNotesText, 
      combinedInvoiceNotesText: combinedInvoiceNotesText,
      vUnitId: vUnitId,
      vUnitName: vUnitName,
      mMainPrice: mMainPrice,
      mVatAmount: mVatAmount,
      mWoVatAmount: mWoVatAmount
      
      ));
  }
  // load card from database


  //for submit data
  Future<InvoiceInfoDetails> getInvoiceInfoDetails(int iSalesTypeId,String vFloorId,String vTableId,
   String vCustomerId, String vCustomerAddress,String carNumber) async {
    List<InvoiceDetail> invoiceDetailsList = [];
    // Name with Modifier Serial
    String itemExtra = '';
    // for maintaing modifier Serial number 
    int modifierItemExtraId = 1;

    for (int i = 0; i < cartDetailsModelList.value.length; i++) {

      CartDetailsModel cartDetailsModel = cartDetailsModelList.value[i];
      
      // If item does not have any modifier
      if(cartDetailsModel.onlineModifierLists.isEmpty){
         itemExtra = "0#${cartDetailsModel.itemId}";
      }
      else{
        // If Item have modifier then Name start with modifier serial 1
        itemExtra = "$modifierItemExtraId#${cartDetailsModel.itemId}";
      }

      invoiceDetailsList.add(
        // Main Item add

        InvoiceDetail(
          vInvoiceId: loginController.getInvoiceId, 
          vItemId: cartDetailsModel.itemId, 
          vItemName: cartDetailsModel.itemName, 
          vUnitId: cartDetailsModel.vUnitId,
          vUnitName: cartDetailsModel.vUnitName,
          mQuantity: cartDetailsModel.orderedQty, 
          mCosting: 0.000, 
          vVatCatId: cartDetailsModel.vatCatId,
          mVatPercent: cartDetailsModel.vatPercent,
          vVatOption: cartDetailsModel.vatCatOption, 
          mMainPrice: cartDetailsModel.mFinalPrice,
          mNetAmount: (cartDetailsModel.mFinalPrice * cartDetailsModel.orderedQty),
          mDisPercent: 0.000,
          mDisAmount: cartDetailsModel.discountAmount, 
          mDisCalculated: cartDetailsModel.discountAmount,
          mAmountAfterDis: (cartDetailsModel.mMainPrice * cartDetailsModel.orderedQty),
          mVoidPercent: 0.000,
          mVoidAmount: 0.000,
          mVoidCalculated: 0.000,
          mAmountAfterDisVoid: 0.000,
          mAmountWithoutVat: (cartDetailsModel.mWoVatAmount * cartDetailsModel.orderedQty),
          mTotalVatAmount: (cartDetailsModel.mVatAmount * cartDetailsModel.orderedQty), 
          mFinalPrice: cartDetailsModel.mFinalPrice,
          mFinalAmount: (cartDetailsModel.mFinalPrice * cartDetailsModel.orderedQty),
          iClosed: 0,
          vItemExtra: itemExtra,
          vKitchenNote: cartDetailsModel.combinedKitchenNotesText,
          vInvoiceNote: cartDetailsModel.combinedInvoiceNotesText,
          vRemarks: "",
          iInvoiceStatusId: 1, 
          vStatusRemarks: "",
          vCreatedBy: loginController.userIdFromLocalStorage,
          dCreatedDate: DateTime.now(), 
          vModifiedBy: loginController.userIdFromLocalStorage, 
          dModifiedDate: DateTime.now()
        )
      );

      if(cartDetailsModel.onlineModifierLists.isNotEmpty){ 

        for (var modifier in cartDetailsModel.onlineModifierLists) {
          // Modifier name starts with modifier serial 
          itemExtra = "$modifierItemExtraId#${cartDetailsModel.itemId}";

          invoiceDetailsList.add(
            // Modifier add
            InvoiceDetail(
              vInvoiceId: loginController.getInvoiceId, 
              vItemId: modifier.vItemIdModifier, 
              vItemName: modifier.vItemName, 
              vUnitId: modifier.iUnitId,
              vUnitName: modifier.vUnitName,
              mQuantity: cartDetailsModel.orderedQty,
              mCosting: 0.000, 
              vVatCatId: modifier.vVatCatId,
              mVatPercent: modifier.mPercentage,
              vVatOption: modifier.vVatOption, 
              mMainPrice: modifier.mMainPrice,
              mNetAmount: (modifier.mFinalPrice * cartDetailsModel.orderedQty),
              mDisPercent: 0.000,
              mDisAmount: 0.000, 
              mDisCalculated: 0.000,
              mAmountAfterDis: (modifier.mMainPrice * cartDetailsModel.orderedQty),
              mVoidPercent: 0.000,
              mVoidAmount: 0.000,
              mVoidCalculated: 0.000,
              mAmountAfterDisVoid: 0.000,
              mAmountWithoutVat: (modifier.mWoVatAmount * cartDetailsModel.orderedQty),
              mTotalVatAmount: (modifier.mVatAmount * cartDetailsModel.orderedQty), 
              mFinalPrice: modifier.mFinalPrice,
              mFinalAmount: (modifier.mFinalPrice * cartDetailsModel.orderedQty),
              iClosed: 0,
              vItemExtra: itemExtra,
              vKitchenNote: "",
              vInvoiceNote: "",
              vRemarks: "",
              iInvoiceStatusId: 1, 
              vStatusRemarks: "",
              vCreatedBy: loginController.userIdFromLocalStorage,
              dCreatedDate: DateTime.now(), 
              vModifiedBy: loginController.userIdFromLocalStorage, 
              dModifiedDate: DateTime.now()
            )
          );

        }
        // modifier serial should increase with modifier lenght
        // If next Item has not modifier in same order prefex will be zero 
        // After that with same order modifier serial starts with increase's value  
        modifierItemExtraId = modifierItemExtraId + cartDetailsModel.onlineModifierLists.length;
      }
      // when a Item add modifier should serial increase
      modifierItemExtraId ++;
    }
    InvoiceInfo invoiceInfo = InvoiceInfo(
      vBranchId: loginController.branchIdFromLocalStorage,
      vInvoiceId: loginController.getInvoiceId,
      vInvoiceNo: loginController.getInvoiceNo,
      vBarcode: "",
      vSplitTicketId: "",
      iSalesTypeId: iSalesTypeId,
      iStatusId: 1, 
      iClosed: 0, 
      vFloorId: vFloorId,
      vTableId: vTableId, 
      vWaiterId: loginController.userIdFromLocalStorage, 
      vPromotionId: "", 
      vDriverId: "", 
      vZoneId: "", 
      vCustomerId: vCustomerId, 
      vCustomerAddress: vCustomerAddress, 
      iNoOfCustomers: 1, 
      dSaveDate: DateTime.now(), 
      dSettleDate: DateTime.now(), 
      dDeliveryDate: DateTime.now(), 
      mBillAmount: double.parse(totalBillAmount.toStringAsFixed(3)) , 
      mPaidAmount: double.parse(0.toStringAsFixed(3)) , 
      vSpecialNote: "", 
      vRemarksForVoid: "", 
      //vTerminalName: await getDeviceinfo(), 
      vTerminalName: "", 
      vCreatedBy: loginController.userIdFromLocalStorage, 
      dCreatedDate: DateTime.now(), 
      vModifiedBy: loginController.userIdFromLocalStorage, 
      dModifiedDate: DateTime.now(), 
      invoiceDetails: invoiceDetailsList, 
      invoiceSettle: [],
      vSyncedMacId: "",
      iSynced: "0",
      vUniqueId: await getUniqueId(),
      vCarNumber: carNumber
    );

    List<InvoiceInfo> invoiceInfoList = [invoiceInfo];
    InvoiceInfoDetails  invoiceData = InvoiceInfoDetails(invoiceInfo: invoiceInfoList);
    return invoiceData;
  }
}