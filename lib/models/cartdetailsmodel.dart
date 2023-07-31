import 'package:hitechpos/models/itemdetails.dart';

class CartDetailsModel{
  String itemId;
  String itemName;
  int orderedQty;
  double itemPrice;
  double totalPrice;
  ItemPriceList itemPriceList;
  List<OnlineModifierList> onlineModifierLists;
  String combinedKitchenNotesText;
  String combinedInvoiceNotesText;
  CartDetailsModel(
    {
      required this.itemId,
      required this.itemName,
      required this.orderedQty,
      required this.itemPrice,
      required this.totalPrice,
      required this.itemPriceList,
      required this.onlineModifierLists,
      required this.combinedKitchenNotesText,
      required this.combinedInvoiceNotesText
    }
  );
}