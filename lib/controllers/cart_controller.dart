import 'package:get/get.dart';
import 'package:hitechpos/models/cartDetailsmodel.dart';
import 'package:hitechpos/models/itemdetails.dart';

class CartController extends GetxController{

  Rx< List<CartDetailsModel> >cartDetailsModelList = Rx<List<CartDetailsModel>>([]);

  void addToCart(
  String itemId,
  String itemName,
  int orderedQty,
  double itemPrice,
  double totalPrice,
  ItemPriceList itemPriceList,
  List<OnlineModifierList> onlineModifierLists,
  String combinedKitchenNotesText,
  String combinedInvoiceNotesText)
  {
    cartDetailsModelList.value.add(
      CartDetailsModel(itemId: itemId, itemName: itemName, orderedQty: orderedQty, itemPrice: itemPrice, totalPrice: totalPrice, 
      itemPriceList: itemPriceList, onlineModifierLists: onlineModifierLists,
      combinedKitchenNotesText: combinedKitchenNotesText, 
      combinedInvoiceNotesText: combinedInvoiceNotesText ));
  }

  
}