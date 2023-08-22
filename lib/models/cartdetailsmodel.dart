import 'package:hitechpos/models/itemdetails.dart';

class CartDetailsModel{
  String itemId;
  String itemName;
 // String modifiedBy;
  int orderedQty;
  double mFinalPrice;
  double totalPrice;
  double discountAmount;
  String vatCatId;
  String vatCatOption;
  double vatPercent;

  String vUnitId;
  String vUnitName;

  double mMainPrice;
  double mVatAmount;
  double mWoVatAmount;
  //double totalVatAmount;
  //double finalAmount;
  //double mainPrice;
  //double netAmount;
 // double amountWithoutVat;
  //double vatAmount;
  //ItemPriceList itemPriceList;
  List<OnlineModifierList> onlineModifierLists;
  String combinedKitchenNotesText;
  String combinedInvoiceNotesText;
  CartDetailsModel(
    {
      required this.itemId,
      required this.itemName,
      //required this.modifiedBy,
      required this.orderedQty,
      required this.mFinalPrice,
      required this.totalPrice,
      required this.discountAmount,
      required this.vatCatId,
      required this.vatCatOption,
      required this.vatPercent,
      //required this.totalVatAmount,
      //required this.finalAmount,
      //required this.mainPrice,
      //required this.netAmount,
      //required this.amountWithoutVat,
      //required this.vatAmount,
      //required this.itemPriceList,
      required this.onlineModifierLists,
      required this.combinedKitchenNotesText,
      required this.combinedInvoiceNotesText,
      required this.vUnitId,
      required this.vUnitName,
      required this.mMainPrice, 
      required this.mVatAmount,
      required this.mWoVatAmount
      
    }
  );
}