import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/models/cartDetailsmodel.dart';
import 'package:hitechpos/views/menu/menu_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';
import 'package:badges/badges.dart' as badges;
import '../proceedorder/proceed_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  
  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  final cartController = Get.find<CartController>();
  late Rx<List<CartDetailsModel>> cartDetailsModelList;
  double totalPrice = 0.000;
  double totalVatAmount = 0.000;
  double totalPriceWithoutVate = 0.000;
  double discountAmount = 0.000;

  double totalModifierAmount= 0.000;
  double totalModifierVatAmount= 0.000;
  double totalModifierWithOutVatAmount = 0.000;
 // double grandTotal = 0.000;
 // double grandTotalVat = 0.000;

  @override
  void initState() {
    cartDetailsModelList = cartController.cartDetailsModelList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    totalPrice = 0.000;
    totalVatAmount = 0.000;
    totalPriceWithoutVate = 0.000;
    discountAmount = 0.000;

    totalModifierAmount= 0.000;
    totalModifierVatAmount= 0.000;
    totalModifierWithOutVatAmount = 0.000;
    
    final cartController = Get.find<CartController>();
    Size size = MediaQuery.of(context).size;
    var contentTitleFontSize = (size.width < 600)? Palette.contentTitleFontSize : Palette.contentTitleFontSizeL;
    var discriptionFontSize = (size.width < 600)? Palette.discriptionFontSize : Palette.discriptionFontSizeL;


    for (var cartOrder in cartDetailsModelList.value) {

      double modifierPrice = 0.000;
      double modifiervat = 0.000;
      double modifierWithoutvatAmount = 0.000;
      
      debugPrint(cartOrder.onlineModifierLists.length.toString());
      for(var modifier in cartOrder.onlineModifierLists){
        modifierPrice += (modifier.mFinalPrice * modifier.mQuantity) ;
        modifiervat += (modifier.mVatAmount * modifier.mQuantity);
        modifierWithoutvatAmount += (modifier.mWoVatAmount * modifier.mQuantity);
      }

      totalPrice += (modifierPrice * cartOrder.orderedQty) + (cartOrder.mFinalPrice * cartOrder.orderedQty);
      cartController.totalBillAmount = totalPrice;
      totalModifierAmount += (modifierPrice * cartOrder.orderedQty);
      totalModifierVatAmount += (modifiervat * cartOrder.orderedQty);
      totalModifierWithOutVatAmount += (modifierWithoutvatAmount * cartOrder.orderedQty.toDouble());
      totalPriceWithoutVate += (modifierWithoutvatAmount * cartOrder.orderedQty.toDouble()) + (cartOrder.mWoVatAmount * cartOrder.orderedQty.toDouble());
      
      totalVatAmount += (modifiervat * cartOrder.orderedQty) + (cartOrder.mVatAmount * cartOrder.orderedQty);
    }
    return WillPopScope(
      onWillPop: () async{
        Get.to(() => MenuScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Palette.bgColorPerple,
          leading: GestureDetector(
            onTap: () {
              Get.to(() => MenuScreen());
            },
            child: const Icon(Icons.arrow_back),
          ),
    
          title: const Text('Cart'),
    
          actions: [
            TextButton(
              onPressed: null,
              child: badges.Badge(
                badgeContent: Text(
                  cartController.cartDetailsModelList.value.length.toString(),
                  style: const TextStyle(
                  color: Colors.white,
                  ),
                ), 
                child: const Icon(Icons.shopping_cart,color: Colors.white,),
              ),
            ),
          ],
          //title: Text('Cart (${currentUser.cart.length})'),
        ),
        body: ListView.separated(
          //lenght +1 for show serial number of item
          itemCount: cartDetailsModelList.value.length +1,
          itemBuilder: (BuildContext context, int index) {
           if (index < cartDetailsModelList.value.length) {
              int orderQuentity = cartDetailsModelList.value[index].orderedQty;
              CartDetailsModel order = cartDetailsModelList.value[index];
              return Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 5,top: 5),
                child: Column(
                  children: [
                    //First Row
                    Row(
                      children: [
                        //First Part
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Name
                                Text( "${index + 1}) ${order.itemName}",
                                style: const TextStyle(
                                  fontSize: Palette.btnFontsize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Palette.layoutFont
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              //Kitchen Note
                              Text("KN: ${order.combinedKitchenNotesText}",
                                style: TextStyle(
                                  fontSize: discriptionFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Palette.layoutFont
                                ),
                              ),
                              //Invoice Note
                              Text("IN: ${order.combinedInvoiceNotesText}",
                                style: TextStyle(
                                  fontSize: discriptionFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Palette.layoutFont
                                ),
                              ),
                            ],
                          )
                        ),
                        
                        //Second Part
                        Container(
                          height: 30,
                        width: size.width > 700 ? 150 : size.width >= 400? 120 : 100 ,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 96, 137),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // - button
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if(order.orderedQty > 1){
                                      order.orderedQty = order.orderedQty - 1;
                                    }
                                  });
                                },
                                child: LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints){
                                    return SizedBox(
                                      width: constraints.maxWidth,
                                      child: const Center(
                                        child: Text('-',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Palette.contentTitleFontSize,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Palette.layoutFont
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ),
                          
                            // Counter Box
                            Expanded(
                              flex: 6,
                              child: Container(
                                height: 25,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                        Color(0xffFFF7F9),
                                        Color(0xffFFFBFC),
                                  ]),
                                  boxShadow: [
                                    BoxShadow(
                                    color: Color.fromRGBO(241, 96, 138, 0.35),
                                    spreadRadius: 5,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text( "$orderQuentity",
                                    style: TextStyle(
                                      fontSize: contentTitleFontSize,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: Palette.layoutFont
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            
                            // + button
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    order.orderedQty = order.orderedQty + 1;
                                  });
                                },
                                child: LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints){
                                    return SizedBox(
                                      width: constraints.maxWidth,
                                      child: const Center(
                                        child: Text('+',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Palette.contentTitleFontSize,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Palette.layoutFont
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ),
                            ),
                          ],
                          ),
                        ),
                        //Price
                        SizedBox(
                          width: size.width > 700 ? 100 : 60,
                          child: Text(
                            (order.mFinalPrice * order.orderedQty).toStringAsFixed(3),
                            style: TextStyle(
                            fontSize: discriptionFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: Palette.layoutFont
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        
                        // Delete Button
                        SizedBox(
                          width: size.width > 700 ? 100 : 50,
                          child: TextButton(
                          onPressed: () {
                            setState(() {
                              cartController.cartDetailsModelList.value.remove(order);
                            });
                          }, 
                          child: const Icon(Icons.delete,color: Palette.bgColorPerple,),
                          ),
                        ),
                        
                      ],
                    ),
                    //Second Row //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("    Add: ",
                                  style: TextStyle(
                                      fontSize: discriptionFontSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Palette.layoutFont
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      child: SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                          itemCount: order.onlineModifierLists.length,
                                          itemBuilder: ( (BuildContext context, index) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("${order.orderedQty} x ${order.onlineModifierLists[index].mQuantity.toStringAsFixed(0)} ${order.onlineModifierLists[index].vItemName}",
                                                    style: TextStyle(
                                                      fontSize: discriptionFontSize,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: Palette.layoutFont
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                ),
                                                Text((order.orderedQty * (order.onlineModifierLists[index].mQuantity * order.onlineModifierLists[index].mFinalPrice)).toStringAsFixed(3),
                                                  style: TextStyle(
                                                    fontSize: discriptionFontSize,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Palette.layoutFont
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            );
                                          } ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width > 700 ? 100 : 50,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            //for bottom
            return const SizedBox(
              height: 160,
            );
          },
          //separator
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1.0,
              color: Colors.grey,
            );
          },
        ),
        
        //Checkout button
        bottomSheet: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Palette.textColorPurple,width: 1)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //first row
                Row(
                  children: [
                    // KN IN full name
                    const Expanded(
                      flex: 6,
                      child: SizedBox(),
                      // Column(
                      //   crossAxisAlignment:CrossAxisAlignment.start,
                      //   children: [
                      //   Text("KN = Kitchen Notes",
                      //       style: TextStyle(
                      //         fontFamily: Palette.layoutFont,
                      //         fontSize: Palette.contentTitleFontSizeL,
                      //         fontWeight: FontWeight.w500,
                      //         color: Palette.textColorLightPurple,
                      //       ),
                      //     ),
                      //     Text("IN = Invoice Notes",
                      //       style: TextStyle(
                      //         fontFamily: Palette.layoutFont,
                      //         fontSize: Palette.contentTitleFontSizeL,
                      //         fontWeight: FontWeight.w500,
                      //         color: Palette.textColorLightPurple,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    //Amount
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Total
                              const Expanded(
                                flex: 4,
                                child: Text(
                                  'Total:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text("BHD",
                                  style: TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textColorPurple,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  totalPriceWithoutVate.toStringAsFixed(3),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textColorPurple,
                                  ),
                                ),
                              ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Discount
                              const Expanded(
                                flex: 4,
                                child: Text(
                                  'Discount:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Expanded(
                              flex: 2,
                               child: Text("BHD",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textColorPurple,
                                  ),
                                ),
                             ),
                              Expanded(
                              flex: 3,
                                child: Text(
                                  0.toStringAsFixed(3),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textColorPurple,
                                  ),
                                ),
                              ),
                              ],
                            ),
                            //VAT
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Discount
                              const Expanded(
                                flex: 4,
                                child: Text(
                                  'VAT:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text("BHD",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textColorPurple,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  totalVatAmount.toStringAsFixed(3),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: Palette.discriptionFontSizeL,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.textColorPurple,
                                  ),
                                ),
                              ),
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                
                  Palette.sizeBoxVarticalSpace,
                  // Row(
                  // children: [
                  //   const Expanded(
                  //       flex: 6,
                  //       child: Text(
                  //         'NET :',
                  //         textAlign: TextAlign.right,
                  //         style: TextStyle(
                  //           fontSize: Palette.discriptionFontSizeL,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 3,
                  //       child: Text(
                  //         'BHD ${(1+totalPrice).toStringAsFixed(3)}',
                  //         textAlign: TextAlign.end,
                  //         style: TextStyle(
                  //           fontSize: Palette.discriptionFontSizeL,
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.green[600],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                TextButton(
                  onPressed: () {
                    
                    Get.to(() => const ProceedScreen(),);
                  },
                  child: CurbButton(
                    buttonPadding: const EdgeInsets.only(left: 0,right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("CONFIRM",
                          style: TextStyle(
                            fontFamily: Palette.layoutFont,
                            fontWeight: Palette.btnFontWeight,
                            fontSize: Palette.btnFontsize,
                            color: Palette.btnTextColor,
                          ),
                        ),
                        Text("BHD ${totalPrice.toStringAsFixed(3)} ",
                          style: const TextStyle(
                            fontFamily: Palette.layoutFont,
                            fontSize: Palette.btnFontsize,
                            fontWeight: Palette.btnFontWeight,
                            color: Colors.white,
                          ),
                        ),
                        const Icon(Icons.add_card,size: 20,color: Colors.white,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}