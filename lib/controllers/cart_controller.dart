import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/cartDetailsmodel.dart';
import 'package:hitechpos/models/invoiceinfodetails.dart';
import 'package:hitechpos/models/itemdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController{

  Rx< List<CartDetailsModel> >cartDetailsModelList = Rx<List<CartDetailsModel>>([]);
  final loginController = Get.find<LoginController>();
  double totalBillAmount = 0.000;
  String uniqueId = "";
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
 // String modifiedBy,
  int orderedQty,
  double itemPrice,
  double totalPrice,
  double discountAmount,
  String vatCatId,
  String vatCatOption,
  double vatPercent,
  //double totalVatAmount,
  // double finalAmount,
  // double mainPrice,
  // double netAmount,
  // double amountWithoutVat,
  // double vatAmount,
  ItemPriceList itemPriceList,
  List<OnlineModifierList> onlineModifierLists,
  String combinedKitchenNotesText,
  String combinedInvoiceNotesText)
  {
    cartDetailsModelList.value.add(  
      CartDetailsModel(itemId: itemId, itemName: itemName,orderedQty: orderedQty, itemPrice: itemPrice, totalPrice: totalPrice,
      discountAmount: discountAmount,vatCatId: vatCatId,vatCatOption: vatCatOption,vatPercent: vatPercent,
      // finalAmount: finalAmount, mainPrice: mainPrice,
      // netAmount: netAmount,amountWithoutVat: amountWithoutVat,vatAmount: vatAmount,
      itemPriceList: itemPriceList, onlineModifierLists: onlineModifierLists,
      combinedKitchenNotesText: combinedKitchenNotesText, 
      combinedInvoiceNotesText: combinedInvoiceNotesText));
  }

  Future<InvoiceInfoDetails> getInvoiceInfoDetails(String iSalesTypeId, String vTableId,
   String vCustomerId, String vCustomerAddress) async {
    
    List<InvoiceDetail> invoiceDetailsList = [];

    for (int i = 0; i < cartDetailsModelList.value.length; i++) {

      CartDetailsModel cartDetailsModel = cartDetailsModelList.value[i];

      List<String> itemExtraIds = [];
      for (var modifier in cartDetailsModel.onlineModifierLists) {
        String modifierWithProductSerial = "$i#${modifier.vItemIdModifier}";
        itemExtraIds.add(modifierWithProductSerial);
      }

      String combinedModifierList = itemExtraIds.join(',');

      invoiceDetailsList.add(
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
          iClosed: '1',
          vItemExtra: combinedModifierList,
          vKitchenNote: cartDetailsModel.combinedKitchenNotesText,
          vInvoiceNote: cartDetailsModel.combinedInvoiceNotesText,
          vRemarks: "",
          iInvoiceStatusId: "0", 
          vStatusRemarks: "",
          vCreatedBy: loginController.userIdFromLocalStorage,
          dCreatedDate: DateTime.now(), 
          vModifiedBy: "", 
          dModifiedDate: DateTime.now()
        )
      );
    }

    InvoiceInfo invoiceInfo = InvoiceInfo(
      vBranchId: loginController.branchIdFromLocalStorage,
      vInvoiceId: "",
      vInvoiceNo: "",
      vBarcode: "",
      vSplitTicketId: "",
      iSalesTypeId: iSalesTypeId,
      iStatusId: "1", 
      iClosed: "1", 
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
      vTerminalName: "", 
      vCreatedBy: loginController.userIdFromLocalStorage, 
      dCreatedDate: DateTime.now(), 
      vModifiedBy: "", 
      dModifiedDate: DateTime.now(), 
      invoiceDetails: invoiceDetailsList, 
      invoiceSettle: [],
      vSyncedMacId: "",
      iSynced: "0",
      vUniqueId: await getUniqueId()
    );

    List<InvoiceInfo> invoiceInfoList = [invoiceInfo];
    InvoiceInfoDetails  invoiceData = InvoiceInfoDetails(invoiceInfo: invoiceInfoList);
    return invoiceData;
  }
}