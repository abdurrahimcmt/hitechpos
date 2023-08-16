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

  Rx< List<CartDetailsModel> > cartDetailsModelList = Rx<List<CartDetailsModel>>([]);
  final loginController = Get.find<LoginController>();
  double totalBillAmount = 0.000;
  String uniqueId = "";

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
  double itemPrice,
  double totalPrice,
  double discountAmount,
  String vatCatId,
  String vatCatOption,
  double vatPercent,
  ItemPriceList itemPriceList,
  List<OnlineModifierList> onlineModifierLists,
  String combinedKitchenNotesText,
  String combinedInvoiceNotesText)
  {
    cartDetailsModelList.value.add(  
      CartDetailsModel(itemId: itemId, itemName: itemName,orderedQty: orderedQty, itemPrice: itemPrice, totalPrice: totalPrice,
      discountAmount: discountAmount,vatCatId: vatCatId,vatCatOption: vatCatOption,vatPercent: vatPercent,
      itemPriceList: itemPriceList, onlineModifierLists: onlineModifierLists,
      combinedKitchenNotesText: combinedKitchenNotesText, 
      combinedInvoiceNotesText: combinedInvoiceNotesText));
  }

  Future<InvoiceInfoDetails> getInvoiceInfoDetails(String iSalesTypeId, String vTableId,
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
          vInvoiceId: "", 
          vItemId: cartDetailsModel.itemId, 
          vUnitId: cartDetailsModel.itemPriceList.vUnitId,
          mQuantity: cartDetailsModel.orderedQty.toStringAsPrecision(3), 
          mCosting: 0.toStringAsPrecision(3), 
          vVatCatId: cartDetailsModel.vatCatId,
          mVatPercent: cartDetailsModel.vatPercent.toStringAsPrecision(3),
          vVatOption: cartDetailsModel.vatCatOption, 
          mMainPrice: cartDetailsModel.itemPrice.toStringAsFixed(3),
          mNetAmount: (cartDetailsModel.itemPrice * cartDetailsModel.orderedQty).toStringAsPrecision(3),
          mDisPercent: 0.toStringAsPrecision(3),
          mDisAmount: cartDetailsModel.discountAmount.toStringAsPrecision(3), 
          mDisCalculated: cartDetailsModel.discountAmount.toStringAsPrecision(3),
          mAmountAfterDis: cartDetailsModel.totalPrice.toStringAsPrecision(3),
          mVoidPercent: 0.toStringAsPrecision(3),
          mVoidAmount: 0.toStringAsPrecision(3),
          mVoidCalculated: 0.toStringAsPrecision(3),
          mAmountAfterDisVoid: 0.toStringAsPrecision(3),
          mAmountWithoutVat: (cartDetailsModel.itemPriceList.mWoVatAmount * cartDetailsModel.orderedQty).toStringAsPrecision(3),
          mTotalVatAmount: (cartDetailsModel.itemPriceList.mVatAmount * cartDetailsModel.orderedQty).toStringAsPrecision(3), 
          mFinalPrice: cartDetailsModel.itemPrice.toStringAsPrecision(3),
          mFinalAmount: (cartDetailsModel.itemPrice * cartDetailsModel.orderedQty).toStringAsPrecision(3),
          iClosed: '0',
          vItemExtra: itemExtra,
          vKitchenNote: cartDetailsModel.combinedKitchenNotesText,
          vInvoiceNote: cartDetailsModel.combinedInvoiceNotesText,
          vRemarks: "",
          iInvoiceStatusId: "1", 
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
              vInvoiceId: "", 
              vItemId: modifier.vItemIdModifier, 
              vUnitId: modifier.iUnitId,
              mQuantity: modifier.mQuantity.toStringAsPrecision(3), 
              mCosting: 0.toStringAsPrecision(3), 
              vVatCatId: modifier.vVatCatId,
              mVatPercent: modifier.mPercentage.toStringAsPrecision(3),
              vVatOption: modifier.vVatOption, 
              mMainPrice: modifier.mMainPrice.toStringAsFixed(3),
              mNetAmount: (modifier.mFinalPrice * cartDetailsModel.orderedQty).toStringAsPrecision(3),
              mDisPercent: 0.toStringAsPrecision(3),
              mDisAmount: 0.toStringAsPrecision(3), 
              mDisCalculated: 0.toStringAsPrecision(3),
              mAmountAfterDis: (modifier.mFinalPrice * cartDetailsModel.orderedQty).toStringAsPrecision(3),
              mVoidPercent: 0.toStringAsPrecision(3),
              mVoidAmount: 0.toStringAsPrecision(3),
              mVoidCalculated: 0.toStringAsPrecision(3),
              mAmountAfterDisVoid: 0.toStringAsPrecision(3),
              mAmountWithoutVat: (modifier.mWoVatAmount * cartDetailsModel.orderedQty).toStringAsPrecision(3),
              mTotalVatAmount: (modifier.mVatAmount * cartDetailsModel.orderedQty).toStringAsPrecision(3), 
              mFinalPrice: modifier.mFinalPrice.toStringAsPrecision(3),
              mFinalAmount: (modifier.mFinalPrice * cartDetailsModel.orderedQty).toStringAsPrecision(3),
              iClosed: '0',
              vItemExtra: itemExtra,
              vKitchenNote: "",
              vInvoiceNote: "",
              vRemarks: "",
              iInvoiceStatusId: "1", 
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
      vInvoiceId: "",
      vInvoiceNo: "",
      vBarcode: "",
      vSplitTicketId: "",
      iSalesTypeId: iSalesTypeId,
      iStatusId: "1", 
      iClosed: "0", 
      vTableId: vTableId, 
      vWaiterId: loginController.userIdFromLocalStorage, 
      vPromotionId: "", 
      vDriverId: "", 
      vZoneId: "", 
      vCustomerId: vCustomerId, 
      vCustomerAddress: vCustomerAddress, 
      iNoOfCustomers: "1", 
      dSaveDate: DateTime.now(), 
      dSettleDate: DateTime.now(), 
      dDeliveryDate: DateTime.now(), 
      mBillAmount: totalBillAmount.toStringAsFixed(3), 
      mPaidAmount: 0.toStringAsFixed(3), 
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